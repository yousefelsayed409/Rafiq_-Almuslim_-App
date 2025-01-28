import 'dart:io';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quranapp/core/service/prayer_time_service.dart';
import 'package:flutter/material.dart';



class LocationService {
  loc.Location location = loc.Location();

  Future<bool> requestLocationPermission(BuildContext context) async {
    try {
      PermissionStatus permissionStatus = await Permission.location.request();

      bool isConnected = await _checkInternetConnection();

      if (permissionStatus == PermissionStatus.granted && isConnected) {
        print("Location permission granted and internet connected!");
        context.read<PrayerTimeService>().fetchPrayerTimes();
        return true;
      } else {
        print("Permission denied or no internet connection!");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _checkInternetConnection() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      print("No internet connection: $e");
      return false;
    }
  }
}
