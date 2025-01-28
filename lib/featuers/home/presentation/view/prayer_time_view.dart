import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quranapp/core/service/notification_service.dart';
import 'package:quranapp/core/service/service.dart';
import 'package:quranapp/core/utils/app_assets.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/service/prayer_time_service.dart';
import 'package:quranapp/core/widgets/clock.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quranapp/core/widgets/lottie.dart';
import 'package:quranapp/featuers/home/presentation/view/widget/pray_card.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class PrayerTimeView extends StatefulWidget {
  const PrayerTimeView({super.key});

  @override
  State<PrayerTimeView> createState() => _PrayerTimeViewState();
}

class _PrayerTimeViewState extends State<PrayerTimeView> {
  final LocationService _locationService = LocationService();
  final NotificationService notificationService = NotificationService();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool isPermissionDenied = false;

  @override
  void initState() {
    super.initState();
    _requestLocation(); 
    // notificationService.getToken();
    // notificationService.initializeLocalNotifications(context);
    // notificationService.setupFirebaseMessaging(context);
    // notificationService.setupIntrectMessage(context);
    // notificationService.getAccessToken();
    tz.initializeTimeZones();
  }

  
  Future<void> _schedulePrayerNotifications(Map<String, String> timings) async {
    await _flutterLocalNotificationsPlugin.cancelAll();

    final prayerTimes = {
      'الفجر': timings['Fajr'].toString(),
      'الظهر': timings['Dhuhr'].toString(),
      'العصر': timings['Asr'].toString(),
      'المغرب': timings['Maghrib'].toString(),
      'العشاء': timings['Isha'].toString(),
    };

    prayerTimes.forEach((name, time) {
      final scheduleTime = _parseTimeToTZDateTime(time);

      if (scheduleTime != null) {
        // جدولة الإشعار الأول قبل الصلاة بـ10 دقائق
        final preNotificationTime =
            scheduleTime.subtract(const Duration(minutes: 10));
        _scheduleNotification(
            '$name - قريبًا',
            'تبقى 10 دقائق على صلاة $name',
            preNotificationTime);

        // جدولة الإشعار الثاني عند موعد الصلاة
        _scheduleNotification(
            '$name - الآن', 'حان الآن وقت صلاة $name', scheduleTime);
      }
    });
  }

  tz.TZDateTime? _parseTimeToTZDateTime(String time) {
    final now = tz.TZDateTime.now(tz.local);
    final parts = time.split(':');
    if (parts.length != 2) return null;

    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;

    final scheduledTime =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    return scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1))
        : scheduledTime;
  }

  Future<void> _scheduleNotification(
      String title, String body, tz.TZDateTime scheduledTime) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      title.hashCode,
      title,
      body,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel_id',
          'Prayer Notifications',
          channelDescription: 'إشعارات مواقيت الصلاة',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> _requestLocation() async {
    bool permissionGranted =
        await _locationService.requestLocationPermission(context);

    if (permissionGranted) {
      setState(() => isPermissionDenied = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم الحصول على إذن الموقع بنجاح.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() => isPermissionDenied = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب السماح بإذن الموقع لعرض مواقيت الصلاة.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String formatTime(String time) {
    final DateTime parsedTime = DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm a").format(parsedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimeService>(
      builder: (BuildContext context, value, Widget? child) {
        var jsonData = value.getJson();

        if (isPermissionDenied) {
          return Scaffold(
            body: Center(
              child: Text(
                'يجب السماح بإذن الموقع لعرض مواقيت الصلاة.',
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          );
        }

        if (jsonData == null ||
            jsonData['data'] == null ||
            jsonData['data']['timings'] == null) {
          return  Scaffold(
            body: Center(
              child: circleLoading(150.0 , 150.0),
            ),
          );
        }

        dynamic values = jsonData['data']['timings'];
        _schedulePrayerNotifications(Map<String, String>.from(values));

        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.moveColor,
            body: Stack(
              children: [
                Positioned(
                  child: Image.asset(
                    AppAssets.imagePrayerTime,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: 350.w,
                      height: 270.h,
                      child: const Clock(),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.moveColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            prayCard(
                              icon: CupertinoIcons.sunrise_fill,
                              label: "الفجر",
                              time: formatTime(values['Fajr'].toString()),
                            ),
                            prayCard(
                              icon: Icons.sunny,
                              label: "الظهر",
                              time: formatTime(values['Dhuhr'].toString()),
                            ),
                            prayCard(
                              icon: Icons.wb_twilight_rounded,
                              label: "العصر",
                              time: formatTime(values['Asr'].toString()),
                            ),
                            prayCard(
                              icon: CupertinoIcons.sunset_fill,
                              label: "المغرب",
                              time: formatTime(values['Maghrib'].toString()),
                            ),
                            prayCard(
                              icon: Icons.nights_stay,
                              label: "العشاء",
                              time: formatTime(values['Isha'].toString()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
      },
    );
  }
}
