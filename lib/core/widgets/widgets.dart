import 'dart:io';

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/widgets/azkar_item.dart';
import 'package:quranapp/core/widgets/hadith_item.dart';
import 'package:quranapp/featuers/home/presentation/manger/azkar_cubit/azkar_cubit.dart';
import 'package:quranapp/featuers/home/presentation/manger/quran_cubit/app_cubit.dart';
import 'package:quranapp/featuers/home/presentation/view/surrah_view.dart';
import 'package:we_slide/we_slide.dart';



String? selectedValue;
bool joinedAsmaaAllahScreenBefore = false;
bool joinedHadeethsScreenBefore = false;
 String? surahNameFromSharedPref = '';
int? surahNumFromSharedPref = 0;
int? pageNumberFromSharedPref = 0;
bool internetConnection = false;
bool locationPermission = false;
List<String> surahsUrls = [];
const quranSoundUrl = 'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/';

Future awesomeDialog(BuildContext context, String title, String text,
    {DialogType dialogType = DialogType.question}) async {
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    animType: AnimType.topSlide,
    dialogType: dialogType,
    isDense: true,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    dialogBackgroundColor: const Color(0xff22211f),
    borderSide: const BorderSide(color: Colors.black, width: 4),
    width: MediaQuery.of(context).size.width * 0.9,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Center(
            child: defaultText(
              text: title,
              fontsize: 36,
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          defaultText(
            text: 'التفسير',
            fontsize: 24,
            textColor: Colors.white,
          ),
          myDivider(),
          defaultText(
            text: text,
            fontsize: 20,
            txtDirection: TextDirection.rtl,
            textColor: Colors.white,
          ),
        ],
      ),
    ),
  ).show();
}

 AwesomeDialog onScreenOpen(context) => AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dialogBackgroundColor: Color(0xff22211f),
      title: 'اضغط للتفسير',
      titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal'),
      btnOkText: 'حسنا',
      btnOk: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: defaultColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: defaultText(text: 'حسنا', fontsize: 20, textColor: Colors.white),
      ),
    )..show();



Widget myDivider() => Container(
      width: double.infinity,
      color: Colors.grey,
      height: 1,
    );

Widget myPanel({
  required Widget screen,
  required BuildContext context,
  required AppCubit cubit,
}) {
  return WeSlide(
    panel: cubit.quranSoundActive
        ? InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: SurahScreen(surahNumber: cubit.surahNumber),
                      type: PageTransitionType.bottomToTop));
            },
            child: Container(
                padding: EdgeInsets.fromLTRB(2.w, .2.h, 0.3.w, 1.w),
                color: Color(0xff22211f).withOpacity(0.95),
                child: Row(
                  children: [
                    Image.asset('assets/images/العفاسي.jpg',
                        width: 17.w, height: 17.w),
                    SizedBox(
                      width: 3.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defaultText(
                          textColor: Colors.white,
                          text: "سورة  ${cubit.surahName}",
                          fontsize: 17,
                          txtDirection: TextDirection.rtl,
                          fontWeight: FontWeight.bold,
                        ),
                        defaultText(
                            text: "الشيخ مشاري العفاسي",
                            textColor: Colors.white,
                            fontsize: 13,
                            textOverflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Spacer(),
                    Align(
                        widthFactor: .6,
                        alignment: Alignment.center,
                        child: playIconButton(
                          cubit: cubit,
                          context: context,
                          surahNumber: cubit.surahNumber,
                        )),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      widthFactor: 1,
                      child: IconButton(
                        icon: CircleAvatar(
                          radius: 13,
                          backgroundColor: Color(0xfffefbec),
                          child: Icon(
                            Icons.close,
                            color: Color(0xff22211f),
                            size: 20,
                          ),
                        ),
                        onPressed: () {
                          cubit.changeQuranSoundActive();
                        },
                      ),
                    )
                  ],
                )),
          )
        : Container(),
    panelMinSize: 10.h,
    panelMaxSize: 10.h,
    body: Container(
      color: Color(0xfffefbec),
      child: screen,
    ),
  );
}
Widget defaultText(
        {required String text,
        double? fontsize,
        double? letterSpacing,
        var txtDirection,
        FontWeight? fontWeight,
        isUpperCase = false,
      
        textColor,
        double? textHeight,
        linesMax,
        TextOverflow? textOverflow,
        FontStyle? fontStyle,
        TextStyle? hintStyle,
        TextAlign? textAlign}) =>
    Text(
      isUpperCase ? text.toUpperCase() : text,
      textDirection: txtDirection,
      maxLines: linesMax,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontsize,
          color: textColor,
          height: textHeight,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
Widget playIconButton({required AppCubit cubit, context, surahNumber}) =>
    Padding(
      padding: EdgeInsets.only(right: 2.5.w),
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Color(0xfffefbec),
        onPressed: () {
          if (!cubit.isDownloading) {
            if (cubit.isCached) {
              cubit.togglePlay();
            } else {
              if (!internetConnection) {
                defaultFlutterToast(msg: 'لا يوجد اتصال بالانترنت');
              } else if (!cubit.isPlaying && internetConnection) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.noHeader,
                  animType: AnimType.scale,
                  title: 'هل تود تحميل السورة ؟',
                  desc:
                      "عند تحميل السورة سيمكنك لاحقا الاستماع لها بدون انترنت",
                  btnOkOnPress: () {
                    cubit.downloadSurahSound();
                  },
                  btnOkText: 'نعم',
                  btnOkColor: defaultColor,
                  btnCancelOnPress: () {
                    if (cubit.quranSoundUrl !=
                        "$quranSoundUrl$surahNumber.mp3") {
                      cubit.setUrlQuranSoundSrcOnline(
                          urlSrc: "$quranSoundUrl$surahNumber.mp3");
                    }
                    cubit.togglePlay();
                  },
                  btnCancelText: 'لا',
                  btnCancelColor: Colors.red,
                ).show();
              } else {
                cubit.togglePlay();
              }
            }
          }
        },
        child: Icon(
          cubit.soundIcon,
          color: Color(0xff22211f),
        ),
      ),
    );

void navigateTo(context, nextPage) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ),
    );
    AppBar defaultAppBar(
        {required String text,
       
        double fontSize = 20,
        List<Widget>? actions,
        Widget? leading}) =>
    AppBar(  
      elevation: 0,
      title: Text(
        text,
        style: GoogleFonts.poppins(
                color: Color(0xff18392B), fontWeight: FontWeight.bold),
      ),
      actions: actions,
      centerTitle: true,
      leading: leading,
    );  

Future<bool?> defaultFlutterToast({
  required String msg,
  Color textColor = Colors.white,
  Color backgroundColor = Colors.red,
  Toast toastLength = Toast.LENGTH_LONG,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0);

// void checkInternetConnection(AppCubit cubit) {
//   InternetConnectionChecker().onStatusChange.listen((status) {
//     if (status == InternetConnectionStatus.connected) {
//       internetConnection = true;

//       if (!cubit.gotHadeeths) {
//         cubit.getHadeeth();
//         cubit.getPrayerTime();
//       }
//     } else {
//       internetConnection = false;
//     }
//   });
// }


Widget rightPage(BuildContext context, Widget child) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 4.0, top: 16.0, bottom: 16.0).r,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))
                  .r),
          child: child,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 16.0, bottom: 16.0).r,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))
                  .r),
          child: child,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 12.0, top: 16.0, bottom: 16.0).r,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))
                  .r),
          child: child,
        ),
      ),
    ],
  );
}

Widget leftPage(BuildContext context, Widget child) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4.0, top: 16.0, bottom: 16.0),
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          child: child,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 16.0, bottom: 16.0),
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          child: child,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          child: child,
        ),
      ),
    ],
  );
}





Widget fontSizeDropDown(BuildContext context, var setState, Color color) {
  AzkarCubit cubit = AzkarCubit.get(context);
  return DropdownButton2(
    isExpanded: true,
    items: [
      DropdownMenuItem<String>(
        child: FlutterSlider(
          values: [AzkarItem.fontSizeAzkar],
          max: 40,
          min: 18,
          rtl: true,
          trackBar: FlutterSliderTrackBar(
            inactiveTrackBarHeight: 5,
            activeTrackBarHeight: 5,
            inactiveTrackBar: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
            activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.bluecolor),
          ),
          handlerAnimation: const FlutterSliderHandlerAnimation(
              curve: Curves.elasticOut,
              reverseCurve: null,
              duration: Duration(milliseconds: 700),
              scale: 1.4),
          onDragging: (handlerIndex, lowerValue, upperValue) {
            lowerValue = lowerValue;
            upperValue = upperValue;
            AzkarItem.fontSizeAzkar = lowerValue;
            cubit.saveAzkarFontSize(AzkarItem.fontSizeAzkar);
            setState(() {});
          },
          handler: FlutterSliderHandler(
            decoration: const BoxDecoration(),
            child: Material(
              type: MaterialType.circle,
              color: Colors.transparent,
              elevation: 3,
              child: SvgPicture.asset('assets/image/Settings.svg',
              height: 40.h,
              color: AppColors.bluecolor,
              ),
            ),
          ),
        ),
      )
    ],
    value: selectedValue,
    onChanged: (value) {
      setState(() {
        selectedValue = value as String;
      });
    },
    customButton: Icon(
      Icons.format_size,
      size: 30.h,
      color: color,
    ),
    iconStyleData: IconStyleData(
      iconSize: 40.h,
    ),
    buttonStyleData: ButtonStyleData(
      height: 60.w,
      width: 60.w,
      elevation: 0,
    ),
    dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(.9),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.only(left: 1, right: 1),
        maxHeight: 230,
        width: 280,
        elevation: 0,
        offset: const Offset(0, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(8),
          thickness: MaterialStateProperty.all(6),
        )),
    menuItemStyleData: MenuItemStyleData(
      height: 45.h,
    ),
  );
}


Widget greenContainer(BuildContext context, double height, Widget myWidget,

    {double? width , Color ? colors}) {
  return Container(
    height: height.h,
    width: width!.w,
    decoration: BoxDecoration(
          color: colors?? AppColors.bluecolorobacity,

      borderRadius: BorderRadius.circular(11)
    ),
    // margin: EdgeInsets.symmetric(horizontal: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ClipRRect(
      child: 
        
          myWidget
        
      
    ),
  );
}

Widget fontSizeDropDowntow(BuildContext context, var setState, Color color) {
  AzkarCubit cubit = AzkarCubit.get(context);
  return DropdownButton2(
    isExpanded: true,
    items: [
      DropdownMenuItem<String>(
        child: FlutterSlider(
          values: [HadithItem.fontSizeAzkar],
          max: 40,
          min: 18,
          rtl: true,
          trackBar: FlutterSliderTrackBar(
            inactiveTrackBarHeight: 5,
            activeTrackBarHeight: 5,
            inactiveTrackBar: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
            activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.bluecolor),
          ),
          handlerAnimation: const FlutterSliderHandlerAnimation(
              curve: Curves.elasticOut,
              reverseCurve: null,
              duration: Duration(milliseconds: 700),
              scale: 1.4),
          onDragging: (handlerIndex, lowerValue, upperValue) {
            lowerValue = lowerValue;
            upperValue = upperValue;
            HadithItem.fontSizeAzkar = lowerValue;
            cubit.saveAzkarFontSize(HadithItem.fontSizeAzkar);
            setState(() {});
          },
          handler: FlutterSliderHandler(
            decoration: const BoxDecoration(),
            child: Material(
              type: MaterialType.circle,
              color: Colors.transparent,
              elevation: 3,
              child: SvgPicture.asset('assets/image/Settings.svg',
              color: AppColors.bluecolor,
                            height: 40.h,

              ),
            ),
          ),
        ),
      )
    ],
    value: selectedValue,
    onChanged: (value) {
      setState(() {
        selectedValue = value as String;
      });
    },
    customButton: Icon(
      Icons.format_size,
      size: 30.h,
      color: color,
    ),
    iconStyleData: IconStyleData(
      iconSize: 40.h,
    ),
    buttonStyleData: ButtonStyleData(
      height: 60.w,
      width: 60.w,
      elevation: 0,
    ),
    dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(.9),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.only(left: 1, right: 1),
        maxHeight: 230,
        width: 280,
        elevation: 0,
        offset: const Offset(0, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(8),
          thickness: MaterialStateProperty.all(6),
        )),
    menuItemStyleData: MenuItemStyleData(
      height: 45.h,
    ),
  );
}




Widget customClose(BuildContext context) {
  return GestureDetector(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.close_outlined,
            size: 35.h,
            color: AppColors.white),
        Icon(Icons.close_outlined,
            size: 20.h,
           color: AppColors.white
                 ),
      ],
    ),
    onTap: () {
      Navigator.of(context).pop();
    },
  );
}
