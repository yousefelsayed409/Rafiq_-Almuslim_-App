import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class PrayerTimeService extends ChangeNotifier {
  final bool _clicked = false;
  dynamic _jsonData;
  String _location = 'يرجى تشغيل الموقع';
  bool arabic = true;
  bool done = false;
  bool get clicked => _clicked;
  String get location => _location;

  // تحديد الموقع الحالي
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('خدمات الموقع معطلة.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('تم رفض أذونات الموقع.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('تم رفض أذونات الموقع بشكل دائم، لا يمكننا طلب الأذونات.');
    }

    getData(await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.medium));
  }

  // جلب البيانات باستخدام الموقع الحالي
  Future<void> getData(Position location) async {
    Uri locationUrl =
        Uri.https('api.bigdatacloud.net', '/data/reverse-geocode-client', {
      'latitude': location.latitude.toString(),
      'longitude': location.longitude.toString(),
      'localityLanguage': arabic ? 'ar' : 'en'
    });

    Uri timesUrl = Uri.http('api.aladhan.com', '/v1/timings', {
      'latitude': location.latitude.toString(),
      'longitude': location.longitude.toString(),
      'method': "4",
    });

    try {
      // جلب بيانات الموقع
      http.Response locationResponse = await http.get(locationUrl);
      if (locationResponse.statusCode == 200 || locationResponse.statusCode == 201) {
        _location = (jsonDecode(locationResponse.body)['city']);
      } else {
        print("خطأ في جلب الموقع");
      }

      // جلب أوقات الصلاة
      http.Response timeResponse = await http.get(timesUrl);
      if (timeResponse.statusCode == 200 || timeResponse.statusCode == 201) {
        _jsonData = jsonDecode(timeResponse.body);
      } else {
        print("خطأ في جلب أوقات الصلاة");
      }

      notifyListeners();
    } catch (e) {
      print("حدث خطأ: $e");
    }
  }

  // طريقة جديدة لجلب أوقات الصلاة
  Future<void> fetchPrayerTimes() async {
    try {
      await determinePosition();
    } catch (e) {
      print("خطأ في جلب أوقات الصلاة: $e");
    }
  }

  // انتظار تجهيز البيانات قبل إكمال العمل
  Future<void> waitForPrep(context) async {
    await determinePosition().then((value) {
      if (getJson() == null) {
        waitForPrep(context);
      } else {
        done = true;
      }
      notifyListeners();
    });
  }

  // إرجاع البيانات بشكل JSON
  dynamic getJson() {
    return _jsonData;
  }
}
