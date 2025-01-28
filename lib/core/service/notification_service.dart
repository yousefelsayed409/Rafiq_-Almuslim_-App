import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:quranapp/core/helper/cash_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      AppSettings.openAppSettings();
      print('User declined or has not accepted permission');
    }
  }
 Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        CashNetwork.insertTocash(key: 'Token', value: token);
        print('Device Token: $token');
        return token;
      }
    } catch (e) {
      print('Error getting token: $e');
    }
    return null;
  }
  Future<String?> getAccessToken() async {
  final serviceAccountJson = {
        
  };

  List<String> scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/firebase.database",
    "https://www.googleapis.com/auth/firebase.messaging"
  ];

  try {
    var client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();

    if (credentials.accessToken.expiry.isBefore(DateTime.now())) {
      print("Access token is expired. Fetching a new token...");
      // Fetch new access token
      credentials = await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client,
      );
    }

    // Return the access token
    String accessToken = credentials.accessToken.data;
    print("Access token retrieved: $accessToken");

    // Store the token in cache if necessary
    CashNetwork.insertTocash(key: 'AccessToken', value: accessToken);

    return accessToken;
  } catch (e) {
    print("Error obtaining access token: $e");
    return null;
  }
}
  Future<void> sendNotifications({
    required String fcmToken,
    // required String title,
    required String body,
    //  String? topicname,
    
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();
      
      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/rafeqe-app/messages:send";

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      var response = await dio.post(
        urlEndPoint,
        data: getBody(
          // topic:topicname ,
          // userId: userId,
          fcmToken: fcmToken,
          // title: title,
          body: body,
          type: type ?? "message",
          
        ),
      );

      // Print response status code and body for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error sending notification: $e");
    }
  }    

  Map<String, dynamic> getBody({
    required String fcmToken,
    // required String title,
    required String body,
    //  String? topic,
    String? type,
  }) {
    return {
      "message": {
        // "topic":topic,
        "token": fcmToken,
        "notification": {
          // "title": title,
           "body": body},
        "android": {
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default"
          }
        },
        "apns": {
          "payload": {
            "aps": {"content_available": true}
          }
        },
        "data": {
          "type": type,
          // "id": userId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }
  
  void refreshToken() async {
    _firebaseMessaging.onTokenRefresh.listen((String newToken) {
      print('New token: $newToken');
    });
  }

  void setupFirebaseMessaging(BuildContext context) async {
    await FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('Received a message while in the foreground!');
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data);
        print(message.data['id']);
      }

      if (Platform.isAndroid) {
        initializeLocalNotifications(context);
        showLocalNotification(message);
      } else {
        showLocalNotification(message);
      }
    });
  }

  Future<void> initializeLocalNotifications(BuildContext context) async {
  var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInitializationSettings = const DarwinInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          Map<String, dynamic> payload = json.decode(response.payload!);
          RemoteMessage message = RemoteMessage(
            data: payload,
          );
          handelMessage(context, message);
        }
      });
}


  void handelMessage(BuildContext context, RemoteMessage message) {
    if (message.data['id'] == '12345') {
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return MessageTest(id: message.data['id']);
      // },),);
    }
  }

  Future<void> setupIntrectMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handelMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handelMessage(context, event);
    });
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      'High Importance Notification',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? ""
        ////???!!!!1
        // 'No Title'
        ,
        message.notification?.body ?? 'No Body',
        notificationDetails,
        payload: message.data['data'],
      );
    });
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic: $e');
    }
  }

  Future<void> setupNotificationChannels() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'your_channel_id',
      'Your Channel Name',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }


 Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  } 

   Future<void> schedulePrayerNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    required int id,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel_id',
          'مواقيت الصلاة',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

