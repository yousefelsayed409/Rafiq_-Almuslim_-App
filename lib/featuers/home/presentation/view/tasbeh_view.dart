import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({Key? key}) : super(key: key);

  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class TasbeehItem {
  String text;
  int counter;

  TasbeehItem(this.text, this.counter);

  Map<String, dynamic> toJson() => {
        'text': text,
        'counter': counter,
      };

  factory TasbeehItem.fromJson(Map<String, dynamic> json) {
    return TasbeehItem(
      json['text'] as String,
      json['counter'] as int,
    );
  }
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  final PageController _pageController = PageController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<TasbeehItem> _tasbeehItems = [];
  final List<String> _defaultTasbeehs = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
  ];

  @override
  void initState() {
    super.initState();
    _loadTasbeehItems();
  }

  void _incrementCounter(int index) {
    setState(() {
      _tasbeehItems[index].counter++;
      _saveTasbeehItems();
      _playClickSound();
    });
  }

  void _resetCounter(int index) {
    setState(() {
      _tasbeehItems[index].counter = 0;
      _saveTasbeehItems();
    });
  }

  void _showAddTasbeehDialog({int? index}) {
    String newTasbeeh = index != null ? _tasbeehItems[index].text : '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(index != null ? "تعديل الذكر" : "إضافة ذكر جديد"),
          content: TextField(
            onChanged: (value) {
              newTasbeeh = value;
            },
            decoration: const InputDecoration(hintText: "اكتب الذكر هنا"),
            controller: TextEditingController(text: newTasbeeh),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (index != null) {
                    _tasbeehItems[index].text = newTasbeeh;
                  } else if (newTasbeeh.isNotEmpty) {
                    _tasbeehItems.add(TasbeehItem(newTasbeeh, 0));
                  }
                  _saveTasbeehItems();
                });
                Navigator.of(context).pop();
              },
              child: Text(index != null ? "تعديل" : "إضافة"),
            ),
            if (index != null && !_defaultTasbeehs.contains(_tasbeehItems[index].text))
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _tasbeehItems.removeAt(index);
                    _saveTasbeehItems();
                  });
                  Navigator.of(context).pop();
                },
                child: const Text("حذف"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _loadTasbeehItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasbeehData = prefs.getString('tasbeehItems');
    if (tasbeehData != null) {
      List<dynamic> jsonData = json.decode(tasbeehData);
      _tasbeehItems = jsonData.map((item) => TasbeehItem.fromJson(item)).toList();
    } else {
      _tasbeehItems = _defaultTasbeehs.map((text) => TasbeehItem(text, 0)).toList();
    }
    setState(() {});
  }

  Future<void> _saveTasbeehItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasbeehData = json.encode(_tasbeehItems.map((item) => item.toJson()).toList());
    await prefs.setString('tasbeehItems', tasbeehData);
  }

  Future<void> _playClickSound() async {
    await _audioPlayer.play(AssetSource('sounds/click_sound.mp3'));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          iconTheme: Theme.of(context).primaryIconTheme,
          backgroundColor: AppColors.black1,
          title: Text(
            "المسبحة",
            style: AppTextStyles.tajawalstyle22.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15.h),
              SmoothPageIndicator(
                controller: _pageController,
                count: _tasbeehItems.length,
                effect: const WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: AppColors.green,
                  dotHeight: 12,
                  dotWidth: 12,
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                height: 420.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _tasbeehItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => _incrementCounter(index),
                          child: buildTasbeehCard(
                            _tasbeehItems[index].text,
                            _tasbeehItems[index].counter,
                            index,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () => _incrementCounter(index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(16.sp),
                                child: Icon(Icons.add, size: 24.sp),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _resetCounter(index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(16.sp),
                                child: Icon(Icons.refresh, size: 24.sp),
                              ),
                            ),
                            if (!_defaultTasbeehs.contains(_tasbeehItems[index].text))
                              GestureDetector(
                                onTap: () => _showAddTasbeehDialog(index: index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.oasis,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(16.sp),
                                  child: Icon(Icons.edit, size: 24.sp),
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => _showAddTasbeehDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 20.w,
                  ),
                ),
                child: Text("إضافة ذكر جديد", style: AppTextStyles.tajawalstyle22),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTasbeehCard(String text, int counter, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200.w,
          height: 200.h,
          decoration: BoxDecoration(
            color: AppColors.green,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5.h),
                color: AppColors.white.withOpacity(0.5),
                spreadRadius: 5.r,
                blurRadius: 5.r,
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.kufi16Style.copyWith(fontSize: 25.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -40.h),
          child: Container(
            width: 150.w,
            height: 150.h,
            decoration: BoxDecoration(
              color: AppColors.green,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5.h),
                  color: AppColors.white.withOpacity(0.5),
                  spreadRadius: 2.r,
                  blurRadius: 5.r,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5.h),
                      color: AppColors.black.withOpacity(0.3),
                      spreadRadius: 2.r,
                      blurRadius: 5.r,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      counter.toString(),
                      style: AppTextStyles.tajawalstyle22.copyWith(
                        color: AppColors.black1,
                        fontSize: 40.sp,
                      ),
                    ),
                     Text(
                      "عدد",
                      style: AppTextStyles.tajawalstyle22.copyWith(
                        color: AppColors.black1,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
