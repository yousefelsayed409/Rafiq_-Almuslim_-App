// import 'dart:async';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:quranapp/core/utils/app_color.dart';
// import 'package:quranapp/core/utils/app_styles.dart';
// import 'package:quranapp/core/widgets/brain.dart';
// import 'package:semicircle_indicator/semicircle_indicator.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';

// class ClockHomeWidget extends StatefulWidget {
//   const ClockHomeWidget({super.key});

//   @override
//   State<ClockHomeWidget> createState() => _ClockHomeWidgetState();
// }

// class _ClockHomeWidgetState extends State<ClockHomeWidget>
//     with SingleTickerProviderStateMixin {
//   String time = DateFormat("HH:mm").format(DateTime.now());
//   int seconds = DateTime.now().second;
//   String previous = '--';
//   String next = '--';
//   int minutes = DateTime.now().minute;
//   int hours = DateTime.now().hour;
//   double process = 1;
//   Map<String, String> prayerTimes = {};
//   int diff = 0;

//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();
//     setListOfTimes();
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         seconds = DateTime.now().second;
//         minutes = DateTime.now().minute;
//         hours = DateTime.now().hour;
//         time = DateFormat("HH:mm").format(DateTime.now());

//         getPreviousAndNext();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel(); // إلغاء التايمر عند انتهاء الويدجت.
//     super.dispose();
//   }

//   String changeToArabic(String label) {
//     switch (label) {
//       case "Fajr":
//         return "الفجر";
//       case "Dhuhr":
//         return "الظهر";
//       case "Asr":
//         return "العصر";
//       case "Maghrib":
//         return "المغرب";
//       case "Isha":
//         return "العشاء";
//       default:
//         return "";
//     }
//   }

//   void getPreviousAndNext() {
//     int currentMinutes = hours * 60 + minutes;
//     String lastKey = "";

//     for (final entry in prayerTimes.entries) {
//       int prayerMinutes = int.parse(entry.value.split(":")[0]) * 60 +
//           int.parse(entry.value.split(":")[1]);

//       if (currentMinutes <= prayerMinutes) {
//         next = entry.key;
//         previous = lastKey.isNotEmpty ? lastKey : "Isha";

//         // حساب الفارق بين الوقت الحالي ووقت الصلاة التالية
//         diff = prayerMinutes - currentMinutes;
//         break;
//       }
//       lastKey = entry.key;
//     }
//     if (previous == "Isha" && next.isEmpty) {
//       next = "Fajr"; // إذا كانت بعد العشاء، الوقت التالي هو الفجر
//     }
//   }

//   void setListOfTimes() {
//     var value = context.read<Brain>().getJson()['data']['timings'];
//     for (var key in value.entries) {
//       if (["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"].contains(key.key)) {
//         prayerTimes[key.key] = key.value;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Brain>(builder: (context, value, child) {
//       return SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // const SizedBox(height: 10),
//             Stack(
//               alignment: FractionalOffset.fromOffsetAndSize(
//                   const Offset(10, 40), const Size(20, 40)),
//               children: [
//                 SemicircularIndicator(
//                   bottomPadding: 0.0,
//                   color: AppColors.green,
//                   contain: false,
//                   progress: process,
//                   // backgroundColor: AppColors.black,
//                   radius: 160,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(time, style: AppTextStyles.textstyle50),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               const SizedBox(height: 10),
//                               Text(
//                                   seconds <= 9
//                                       ? "0$seconds"
//                                       : seconds.toString(),
//                                   style: AppTextStyles.text900style20),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       context.watch<Brain>().arabic
//                           ? ": الباقي للصلاة القادمة ${changeToArabic(next)}"
//                           : "Time till $next",
//                       style: AppTextStyles.text900style20.copyWith(
//                           fontFamily: 'vexa',

//                       ),
//                     ),
//                     Text(
//                         "عدد الساعات: ${(diff / 60).floor()} و ${diff % 60} دقيقة و $seconds ثانية",
//                         style: AppTextStyles.text18style600.copyWith(
//                           // fontSize: 16.sp,
//                           fontFamily: 'vexa',
//                             color: AppColors.white)),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
