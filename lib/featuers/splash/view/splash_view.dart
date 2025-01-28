import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quranapp/core/utils/app_assets.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/featuers/home/presentation/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // final LocationService _locationService = LocationService();

  // Future<void> _showLocationPermissionDialog() async {
  //   bool isGranted = await _locationService.requestLocationPermission(context);
    
  //   if (isGranted) {
  //     // إذا وافق المستخدم على إذن الموقع، انتقل إلى الصفحة الرئيسية
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) =>  PrayerTimeView(),
  //       ),
  //     );
  //   } else {
  //     // إذا لم يسمح المستخدم، يمكنك عرض رسالة أخرى أو إعادة المحاولة
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('يجب السماح لإذن الموقع للمتابعة')),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  HomeView(),
        ),
      );
      // _showLocationPermissionDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEF7FF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 30.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // عنوان التطبيق
              Text(
                'رَفِيقِي',
                style: AppTextStyles.text900style20.copyWith(
                  fontFamily: 'vexa',
                  fontSize: 24.sp,
                  color: AppColors.greentow,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              Text(
                'رَفِيق الْمُسْلِمِ فِي حَيَاتِهِ',
                style: AppTextStyles.text900style20.copyWith(
                  fontFamily: 'vexa',
                  fontSize: 24.sp,
                  color: AppColors.greentow,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 2),
              Expanded(
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // صورة الخلفية
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: SvgPicture.asset(
                            AppAssets.splashImage,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: -23,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xffD0DED8),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SizedBox(
                              width: 40.w,
                              height: 40.h,
                              child: const CircularProgressIndicator(
                  color: AppColors.greentow,
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
