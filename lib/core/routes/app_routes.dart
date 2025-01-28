
import 'package:flutter/material.dart';
import 'package:quranapp/featuers/home/presentation/home_view.dart';
import 'package:quranapp/featuers/home/presentation/view/hadith_view.dart';
import 'package:quranapp/featuers/home/presentation/view/hisn_view.dart';
import 'package:quranapp/featuers/home/presentation/view/prayer_time_view.dart';
import 'package:quranapp/featuers/home/presentation/view/qibla_view.dart';
import 'package:quranapp/featuers/home/presentation/view/sahih_%20al_bukhari_view.dart';
import 'package:quranapp/featuers/home/presentation/view/taqwem_view.dart';
import 'package:quranapp/featuers/home/presentation/view/tasbeh_view.dart';
import 'package:quranapp/featuers/home/presentation/view/zakat_view.dart';
import 'package:quranapp/featuers/splash/view/splash_view.dart';


class AppRoute {
  static const splashView = 'SplashView';
  static const homeView = 'HomeView';
  static const zakatCalculatorView = 'ZakatCalculatorView';
  static const tasbeehScreen = 'TasbeehScreen';
  static const taqwemView = 'TaqwemView';
  static const sahihalBukhariView = 'SahihalBukhariView';
  static const hadithView = 'HadithView';
  static const qiblahScreen = 'QiblahScreen';
  static const prayerTimeView = 'PrayerTimeView';
  static const hisnView = 'HisnView';
  

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return SizeTransition3( const SplashView());
         case homeView:
        return SizeTransition5(  HomeView());
         case zakatCalculatorView:
        return SizeTransition5(  ZakatCalculatorView());
         case tasbeehScreen:
        return SizeTransition5( const TasbeehScreen());
         case taqwemView:
        return SizeTransition5(  TaqwemView());
         case sahihalBukhariView:
        return SizeTransition5( const SahihalBukhariView());
         case hadithView:
        return SizeTransition5( const HadithView());
         case qiblahScreen:
        return SizeTransition5( const QiblahScreen());
         case prayerTimeView:
        return SizeTransition5(  const PrayerTimeView());
         case hisnView:
        return SizeTransition5( const HisnView());
      

    

     
    }
    return undefinedRoute();
  }

  static Route undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text('noRouteFound'),
            ),
          )),
    );
  }
}

class SizeTransition3 extends PageRouteBuilder {
  final Widget page;

  SizeTransition3(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 4),
          reverseTransitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SizeTransition5 extends PageRouteBuilder {
  final Widget page;

  SizeTransition5(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(seconds: 2),
          // reverseTransitionDuration:const  Duration(seconds: 2),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerRight,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
