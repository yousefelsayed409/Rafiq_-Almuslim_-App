// import 'dart:convert';

// import 'package:bloc/bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart'as loc;
// import 'package:meta/meta.dart';
// import 'package:http/http.dart' as http;
// part 'prayer_times_state.dart';

// class PrayerTimesCubit extends Cubit<PrayerTimesState> {
 
//   PrayerTimesCubit() : super(PrayerTimesInitial());
  



//   // // تحديد الموقع الحالي
//   // Future<void> determinePosition() async {
//   //   emit(PrayerTimesLoading());
//   //   bool serviceEnabled;
//   //   LocationPermission permission;

//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     emit(PrayerTimesError('خدمات الموقع معطلة.'));
//   //     return;
//   //   }

//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       emit(PrayerTimesError('تم رفض أذونات الموقع.'));
//   //       return;
//   //     }
//   //   }
//   //   if (permission == LocationPermission.deniedForever) {
//   //     emit(PrayerTimesError('تم رفض أذونات الموقع بشكل دائم، لا يمكننا طلب الأذونات.'));
//   //     return;
//   //   }

//   //   Position locationData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
//   //   await getData(locationData);
//   // }

//   // // جلب البيانات باستخدام الموقع الحالي
//   // Future<void> getData(Position location) async {
//   //   Uri locationUrl = Uri.https('api.bigdatacloud.net', '/data/reverse-geocode-client', {
//   //     'latitude': location.latitude.toString(),
//   //     'longitude': location.longitude.toString(),
//   //     'localityLanguage': arabic ? 'ar' : 'en'
//   //   });

//   //   Uri timesUrl = Uri.http('api.aladhan.com', '/v1/timings', {
//   //     'latitude': location.latitude.toString(),
//   //     'longitude': location.longitude.toString(),
//   //     'method': "4",
//   //   });

//   //   try {
//   //     // جلب بيانات الموقع
//   //     http.Response locationResponse = await http.get(locationUrl);
//   //     if (locationResponse.statusCode == 200) {
//   //       _location = jsonDecode(locationResponse.body)['city'];
//   //     } else {
//   //       emit(PrayerTimesError("خطأ في جلب الموقع"));
//   //     }

//   //     // جلب أوقات الصلاة
//   //     http.Response timeResponse = await http.get(timesUrl);
//   //     if (timeResponse.statusCode == 200) {
//   //       _jsonData = jsonDecode(timeResponse.body);
//   //       emit(PrayerTimesLoaded(_jsonData, _location));
//   //     } else {
//   //       emit(PrayerTimesError("خطأ في جلب أوقات الصلاة"));
//   //     }
//   //   } catch (e) {
//   //     emit(PrayerTimesError("حدث خطأ: $e"));
//   //   }
//   // }

//   // // إرجاع البيانات بشكل JSON
//   // dynamic getJson() {
//   //   return _jsonData;
//   // }
// }

