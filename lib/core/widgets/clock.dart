import 'dart:async';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/core/service/prayer_time_service.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> with SingleTickerProviderStateMixin {
  String time = DateFormat("hh:mm a").format(DateTime.now()); // تم التعديل هنا
  int seconds = DateTime.now().second;
  String previos = '--';
  String next = '--';
  bool notified = false;
  late int minuts;
  late int hours;

  double proccess = 1;
  late Map times;
  late int diff = 0;
  late int nextTimer;
  late int prevTimer;
  late var preyerTimes = {};

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setListOfTimes();

      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          seconds = DateTime.now().second;
          minuts = DateTime.now().minute;
          hours = DateTime.now().hour;
          time = DateFormat("hh:mm a").format(DateTime.now()); // تم التعديل هنا
        });

        getPreviousAndNext();

        nextTimer =
            (int.parse(preyerTimes[next].toString().split(":")[0]) * 60 +
                int.parse(preyerTimes[next].toString().split(":")[1]));

        prevTimer =
            (int.parse(preyerTimes[previos].toString().split(":")[0]) * 60 +
                int.parse(preyerTimes[previos].toString().split(":")[1]));

        diff = previos == "Isha" &&
                1439 <= (hours * 60 + minuts) &&
                (hours * 60 + minuts) <= nextTimer
            ? nextTimer + (1439 - (hours * 60 + minuts))
            : nextTimer - (hours * 60 + minuts);

        print(mapToZeroOne((hours * 60 + minuts), prevTimer, nextTimer));
        print(nextTimer);
        print(prevTimer);
        print((hours * 60 + minuts));
      });
    }
  }

  double mapToZeroOne(int value, int minRange, int maxRange) {
    if (minRange == maxRange) {
      return 0.0;
    }

    double proportion = (value - minRange) / (maxRange - minRange).toDouble();
    proportion = proportion.clamp(0.0, 1.0);
    return proportion;
  }

  String changeToArabic(String label) {
    switch (label) {
      case "Fajr":
        return "الفجر";
      case "Dhuhr":
        return "الظهر";
      case "Asr":
        return "العصر";
      case "Maghrib":
        return "المغرب";
      case "Isha":
        return "العشاء";
      default:
        return "";
    }
  }

  void getPreviousAndNext() {
    Iterable<MapEntry> entries = preyerTimes.entries;
    for (final Entry in entries) {
      if ((hours * 60 + minuts) <=
          (int.parse(Entry.value.toString().split(":")[0]) * 60 +
              int.parse(Entry.value.toString().split(":")[1]))) {
        if (Entry.key == ("Fajr")) {
          next = Entry.key;
          previos = "Isha";
          break;
        }
        next = Entry.key;
        break;
      }
      previos = Entry.key;
    }
    previos == "Isha" ? next = "Fajr" : null;
  }

  void setListOfTimes() {
    var value = context.read<PrayerTimeService>().getJson()['data']['timings'];
    setState(() {
      for (var key in value.entries) {
        ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"].contains(key.key)
            ? preyerTimes[key.key] = key.value
            : preyerTimes;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimeService>(builder: (context, value, child) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: FractionalOffset.fromOffsetAndSize(
                    const Offset(10, 60), const Size(20, 40)),
                children: [
                  SemicircularIndicator(
                    strokeCap: StrokeCap.butt,
                    bottomPadding: 0.0,
                    color: AppColors.moveColor,
                    contain: false,
                    progress: proccess,
                    radius: 150,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            value.location,
                            style: AppTextStyles.kufi16Style.copyWith(
                              fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              time,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: AppColors.white,
                                fontSize: 52,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  seconds <= 9
                                      ? "0$seconds"
                                      : seconds.toString(),
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 25,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: AppColors.moveColor,
                    child: SizedBox(
                      height: 35,
                      width: 60,
                      child: Center(
                        child: Text(
                          context.watch<PrayerTimeService>().arabic
                              ? changeToArabic(next)
                              : previos,
                          style: TextStyle(
                            color: kTextColor,
                            fontFamily: 'vexa',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColors.moveColor,
                    child: SizedBox(
                      height: 35,
                      width: 60,
                      child: Center(
                        child: Text(
                          context.watch<PrayerTimeService>().arabic
                              ? changeToArabic(previos)
                              : next,
                          style: TextStyle(
                            color: kTextColor,
                            fontFamily: 'vexa',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.watch<PrayerTimeService>().arabic
                          ? ": الباقي للصلاة القادمة ${changeToArabic(next)}"
                          : "Time till $next",
                      style: AppTextStyles.text900style20.copyWith(
                        fontFamily: 'vexa',
                      ),
                    ),
                    Text(
                      "عدد الساعات: ${(diff / 60).floor()} و ${diff % 60} دقيقة و $seconds ثانية",
                      style: AppTextStyles.text18style600.copyWith(
                        color: AppColors.white,
                        fontFamily: 'vexa',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
