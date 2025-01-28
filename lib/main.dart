import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:quranapp/core/helper/cash_helper.dart';
import 'package:quranapp/core/routes/app_routes.dart';
import 'package:quranapp/core/service/prayer_time_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/shared/cache_helper.dart';
import 'package:quranapp/core/shared/network/dio.dart';
import 'package:quranapp/core/widgets/lists.dart';
import 'package:quranapp/core/widgets/widgets.dart';
import 'package:quranapp/featuers/home/data/model/asmaa_allah_model.dart';
import 'package:quranapp/featuers/home/presentation/manger/Books_cubit/books_cubit.dart';
import 'package:quranapp/featuers/home/presentation/manger/azkar_cubit/azkar_cubit.dart';
import 'package:quranapp/featuers/home/presentation/manger/quran_cubit/app_cubit.dart';
import 'package:quranapp/firebase_options.dart';
import 'featuers/home/presentation/manger/quran_azkar_cubit/quran_azkar_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // ignore: avoid_print
  print('Handling a background message: ${message.notification?.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  CashNetwork.CashInitialization();
   await CacheHelper.init();
   await DioHelper.init();
   Map<String, dynamic> json2 = jsonDecode(asmaaAllahElHosna);
  AsmaaAllahElHosna.fromJson(json2);
   surahNameFromSharedPref = CacheHelper.getData(key: "surahName");
  surahNumFromSharedPref = CacheHelper.getData(key: "surahNumber");
  pageNumberFromSharedPref = CacheHelper.getData(key: "pageNumber");
  print(surahNameFromSharedPref);
  print(surahNumFromSharedPref);
  print(pageNumberFromSharedPref);
  await initializeDateFormatting('ar', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );   
  runApp(const RafeqeApp());
}
  
  
class RafeqeApp extends StatelessWidget {
  const RafeqeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 

        ChangeNotifierProvider(create: (_) => PrayerTimeService()),
          BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(create: (_) => AzkarCubit()),
        BlocProvider<BooksCubit>(
          create: (BuildContext context) => BooksCubit(),
        ),
        BlocProvider<QuranAzkarCubit>(
          create: (BuildContext context) => QuranAzkarCubit()..loadData(),
        ), 
      ],  
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return  const MaterialApp(
            initialRoute: AppRoute.splashView,
            onGenerateRoute: AppRoute.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
