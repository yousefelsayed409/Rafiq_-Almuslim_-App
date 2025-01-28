// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:quranapp/core/function/app_function.dart';
import 'package:quranapp/core/helper/cash_helper.dart';
import 'package:quranapp/core/service/notification_service.dart';
import 'package:quranapp/core/utils/app_assets.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/core/widgets/custom_navigation.dart';
import 'package:quranapp/core/widgets/lists.dart';
import 'package:quranapp/core/widgets/menu_item.dart';
import 'package:quranapp/featuers/home/presentation/view/asmaa_allah_view.dart';
import 'package:quranapp/featuers/home/presentation/view/hadith_view.dart';
import 'package:quranapp/featuers/home/presentation/view/hisn_view.dart';
import 'package:quranapp/featuers/home/presentation/view/prayer_time_view.dart';
import 'package:quranapp/featuers/home/presentation/view/qibla_view.dart';
import 'package:quranapp/featuers/home/presentation/view/quran_karem_view.dart';
import 'package:quranapp/featuers/home/presentation/view/sahih_%20al_bukhari_view.dart';
import 'package:quranapp/featuers/home/presentation/view/taqwem_view.dart';
import 'package:quranapp/featuers/home/presentation/view/tasbeh_view.dart';
import 'package:quranapp/featuers/home/presentation/view/zakat_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: prefer_typing_uninitialized_variables
  var element;
    // ignore: unused_field
    Timer? _timer;

  Random rnd = Random();
  // ignore: unused_field
  late String _gregorianDate;
  // ignore: prefer_final_fields
  NotificationService _notificationService = NotificationService();

  final List<String> arabicMonths = [
    'محرم',
    'صفر',
    'ربيع الأول',
    'ربيع الآخر',
    'جمادى الأولى',
    'جمادى الآخرة',
    'رجب',
    'شعبان',
    'رمضان',
    'شوّال',
    'ذو القعدة',
    'ذو الحجة'
  ];

  @override
  void initState() { 
_notificationService.requestPermission();
    _notificationService.getToken();
    _notificationService.initializeLocalNotifications(context);
    _notificationService.setupFirebaseMessaging(context);
    _notificationService.setupIntrectMessage(context);
    _notificationService.getAccessToken();
    // _notificationService.subscribeToTopic('sendallnotifi');
    _startAutoNotification();
      final now = DateTime.now();
    element = zikr[rnd.nextInt(zikr.length)];
    super.initState();
    _gregorianDate = DateFormat.yMMMMEEEEd('ar').format(now);
  }
  
  void _startAutoNotification() {
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) async {
      String randomBody = listAzkarNotification[rnd.nextInt(listAzkarNotification.length)]; 
      String title = '.'; 
      await _sendNotification(title, randomBody);
    });
  } 

  Future<void> _sendNotification(String title, String body) async {
    await _notificationService.sendNotifications(
      fcmToken: CashNetwork.getCashData(key: 'AccessToken'),
      // title: title,
      body: body,
    );
  }
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    var _today = HijriCalendar.now();
    ArabicNumbers arabicNumber = ArabicNumbers();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Positioned(
              child: Image.asset(
                AppAssets.imagehome,
                fit: BoxFit.cover,
                height: 0.5.sh,
                width: 1.sw,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '❤️${AppFunctions.getGreetings()} ',
                            style: AppTextStyles.kufi16Style.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${arabicNumber.convert(_today.hDay)} / '
                            '${arabicMonths[_today.hMonth - 1]} / '
                            '${arabicNumber.convert(_today.hYear)} هـ',
                            style: AppTextStyles.kufi16Style,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      // SvgPicture.asset(
                      //   'assets/svg/hijri/${_today.hMonth}.svg',
                      //   color: AppColors.white,
                      //   height: 50.0.h,
                      // ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.only(
                          top: 8.w,
                          right: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                ": أذكار اليوم  ",
                                style: AppTextStyles.kufi16Style,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Text(
                              element,
                              style: AppTextStyles.naskh22,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                // Align(
                //         alignment: Alignment.topLeft,
                //         child: Container(
                //           padding: EdgeInsets.all(8.w),
                //           decoration: BoxDecoration(
                //             color: Colors.white.withOpacity(0.2),
                //             borderRadius: BorderRadius.circular(20.r),
                //           ),
                //           child:Text(
                //       _gregorianDate,
                //       style: AppTextStyles.kufi16Style,
                //       textAlign: TextAlign.center,
                //     ),
                //         ),
                //       ),
                
                SizedBox(height: 20.h),

                // SizedBox(height:MediaQuery.of),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20.0.r),
                    child: Container(
                      padding: EdgeInsets.only(top: 10.r),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greentow,
                            offset: Offset(5, 5,),
                            blurRadius: 10,
                            blurStyle: BlurStyle.outer,
                            
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        // crossAxisSpacing: 7.w,
                        // mainAxisSpacing: 12.h,
                        children: [
                          MenuItem(
                            onTap: () {
                              NavigationHelper.navigateTo(
                                  context, const PrayerTimeView());
                            },
                            icon: FlutterIslamicIcons.mosque,
                            label: 'أوقات الصلاة',
                          ),
                          MenuItem(
                            onTap: () {
                               NavigationHelper.navigateTo(
                                  context, const QuranKaremView());
                            },
                            icon: FlutterIslamicIcons.quran2,
                            label: 'القرآن الكريم',
                          ),
                          MenuItem(
                            icon: FlutterIslamicIcons.quran,
                            label: 'الأحاديث',
                            onTap: () {
                              NavigationHelper.navigateTo(
                                  context, const HadithView());
                            },
                          ),
                          MenuItem(
                            onTap: () { 
                              
                              AppFunctions.screenModalBottomSheet(
                                context,
                                const QiblahScreen(),
                                color: const Color.fromARGB(255, 48, 48, 48),
                              );
                            },
                            icon: FlutterIslamicIcons.qibla,
                            label: 'القبلة',
                          ),
                          MenuItem(
                            onTap: () {
                              NavigationHelper.navigateTo(
                                  context, const TasbeehScreen());
                            },
                            icon: FlutterIslamicIcons.tasbih3,
                            label: 'المسبحة',
                          ),
                          MenuItem(
                            onTap: () {
                              NavigationHelper.navigateTo(
                                  context, const HisnView());
                            },
                            icon: FlutterIslamicIcons.prayer,
                            label: 'حصن المسلم',
                          ),
                          MenuItem(
                           onTap: () {
                              AppFunctions.screenModalBottomSheet(
                                // color: AppColors.coloBackHadith2,
                                context,  AsmaaAllahView());
                              // NavigationHelper.navigateTo(
                              //     context, const SahihalBukhariView());
                            },
                            icon: FlutterIslamicIcons.allah99,
                            label: 'أسماء الله الحسنى',
                          ),
                          MenuItem(
                            onTap: () {
                              AppFunctions.screenModalBottomSheet(
                                color: AppColors.coloBackHadith2,
                                context, const SahihalBukhariView());
                              // NavigationHelper.navigateTo(
                              //     context, const SahihalBukhariView());
                            },
                            icon: FlutterIslamicIcons.quran,
                            label: 'صحيح البخارى',
                          ),
                          MenuItem(
                            onTap: () {
                              AppFunctions.screenModalBottomSheet(
                                context, const TaqwemView(),
                                // color: const Color.fromARGB(255, 48, 48, 48),
                              );
                            },
                            icon: FlutterIslamicIcons.calendar,
                            label: 'التقويم الهجري',
                          ),
                          MenuItem(
                            onTap: () {},
                            icon: Icons.settings,
                            label: 'الإعدادات',
                          ),
                          MenuItem(
                            onTap: () {
                              NavigationHelper.navigateTo(
                                  context, ZakatCalculatorView());
                            },
                            icon: FlutterIslamicIcons.zakat,
                            label: 'ذكاتك',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



