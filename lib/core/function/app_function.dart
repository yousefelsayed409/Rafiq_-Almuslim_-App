import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/widgets/widgets.dart';
import 'package:quranapp/featuers/home/data/model/calss_model.dart';
import 'package:quranapp/featuers/home/data/model/sahih_model.dart';

class AppFunctions {
  static String getGreetings() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return "صبحكم الله بالخير"; // لتحية الصباح
    } else {
      return "مساكم الله بالخير"; // لتحية المساء
    }
  } 


 static void screenModalBottomSheet(
  BuildContext context,
  Widget child,
  {Color? color}
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: color ?? AppColors.bluecolor,   
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16.r),
        height: MediaQuery.of(context).size.height * 0.90,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: customClose(context),
            ),
            Expanded(child: child),
          ],
        ),
      );
    },
  );
}

}


Future<List<Class>> fetchClasses() async {
  String jsonString = await rootBundle.loadString('assets/books/altib.json');
  final jsonResult = jsonDecode(jsonString);
  return (jsonResult['class'] as List)
      .map((i) => Class.fromJson(i as Map<String, dynamic>))
      .toList();
} 
Future<List<SahihBukhariModels>> fetchAllSahihBukari() async {
  String jsonString = await rootBundle.loadString('assets/books/sahih_al_bukhari.json');
  final jsonResult = jsonDecode(jsonString);
  return (jsonResult['sahihAllBukhari'] as List)
      .map((i) => SahihBukhariModels.fromJson(i as Map<String, dynamic>))
      .toList();
} 
