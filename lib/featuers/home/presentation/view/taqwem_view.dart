import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';

class TaqwemView extends StatefulWidget {
  const TaqwemView({super.key});

  @override
  _TaqwemViewState createState() => _TaqwemViewState();
}

class _TaqwemViewState extends State<TaqwemView> {
  late String _gregorianDate;
  late String _hijriDate;
  late String _currentDay; 

   final List<String> arabicMonths = [
    'محرم', 'صفر', 'ربيع الأول', 'ربيع الآخر',
    'جمادى الأولى', 'جمادى الآخرة', 'رجب', 'شعبان',
    'رمضان', 'شوّال', 'ذو القعدة', 'ذو الحجة'
  ];


  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    // تهيئة التاريخ الميلادي بصيغة عربية
    _gregorianDate = DateFormat.yMMMMEEEEd('ar').format(now);
    _currentDay = DateFormat.EEEE('ar').format(now); // الحصول على اليوم بصيغة عربية

    // تهيئة التاريخ الهجري بصيغة عربية باستخدام مكتبة hijri
    // final hijri = HijriCalendar.fromDate(now);
    // _hijriDate = '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} هـ'; // التاريخ الهجري باللغة العربية
  }

  @override
  Widget build(BuildContext context) {
        var _today = HijriCalendar.now();

        ArabicNumbers arabicNumber = ArabicNumbers();

    return Scaffold( 
      backgroundColor: AppColors.bluecolorobacity,
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              'اليوم: $_currentDay', 
              style: AppTextStyles.vexatextstyle.copyWith(
                color: AppColors.black,
                fontSize: 20
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[100], 
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   Text(
                    'التاريخ الهجري:',
                   style: AppTextStyles.vexatextstyle.copyWith(
                color: AppColors.black,
                fontSize: 20
              ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${arabicNumber.convert(_today.hDay)} / '
                            '${arabicMonths[_today.hMonth - 1]} / '
                            '${arabicNumber.convert(_today.hYear)} هـ',
                            style: AppTextStyles.vexatextstyle.copyWith(
                color: AppColors.black,
                fontSize: 20
              ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 2),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.green[100], 
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                   Text(
                    'التاريخ الميلادي:',
                     style: AppTextStyles.vexatextstyle.copyWith(
                color: AppColors.black,
                fontSize: 20
              ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _gregorianDate,
                     style: AppTextStyles.vexatextstyle.copyWith(
                color: AppColors.black,
                fontSize: 18
              ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
