import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/widgets/azkar_item.dart';
import 'package:quranapp/core/widgets/lists.dart';
import 'package:quranapp/core/widgets/widgets.dart';
import 'package:quranapp/featuers/home/data/model/surah_zikr_model.dart';
import 'package:share_plus/share_plus.dart';


class QuranAzkarView extends StatefulWidget {
  final Surah surah;

  QuranAzkarView({required this.surah});

  @override
  State<QuranAzkarView> createState() => _QuranAzkarViewState();
}

class _QuranAzkarViewState extends State<QuranAzkarView> {
  double lowerValue = 18;
  double upperValue = 40;
  String? selectedValue;
  ArabicNumbers arabicNumbers = ArabicNumbers();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.bluecolor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ).r),
      child: orientation(
          context,
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 55.0).r,
                  child: azkarBuild(context),
                ),
              ), 
 Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0).r,
                    child: greenContainer(
                      context,
                      32.0.h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          fontSizeDropDown(
                              context, setState, AppColors.white),
                          Container(
                            width: 250.w,
                            alignment: Alignment.center,
                            child: Text(
                              widget.surah.name,
                                 
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'vexa',
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                      width: MediaQuery.sizeOf(context).width,
                    ),
                  ),
                ),
              
            ],
          ),
          Stack(
            children: [
              Align(alignment: Alignment.topRight, child: customClose(context)),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 50.0).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        fontSizeDropDown(context, setState,
                            AppColors.white),
                        Align(
                            alignment: Alignment.center,
                            child: Text(widget.surah.name,
                            style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'vexa',
                              ),
                            ),
                          ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1 / 2 * .9,
                  child: azkarBuild(context),
                ),
              ),
            ],
          )),
    );
  }

  Widget azkarBuild(BuildContext context) {
    return ListView.separated(
        itemCount: widget.surah.ayahs.length,
        separatorBuilder: (c, i) => const Divider(
              color: AppColors.grey,
            ),
        itemBuilder: (context, index) {
          final ayah = widget.surah.ayahs[index];
          return ClipRRect(
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: AppColors.bluecolorobacity,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ).r,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8).r,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.symmetric(
                          vertical: BorderSide(
                            color: AppColors.bluecolorobacity,
                            width: 5.w,
                          ),
                        ),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8).r,
                        child: SelectableText(
                          ayah.ayah,
                          style: TextStyle(
                              color: AppColors.black,
                              height: 1.4,
                              fontFamily: 'uthmanic2',
                              fontSize: AzkarItem.fontSizeAzkar),
                          showCursor: true,
                          cursorWidth: 3,
                          cursorColor: AppColors.grey,
                          cursorRadius: const Radius.circular(5),
                          scrollPhysics: const ClampingScrollPhysics(),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8).r,
                        margin: const EdgeInsets.symmetric(horizontal: 8).r,
                        decoration: BoxDecoration(
                            color: AppColors.bluecolorobacity,
                            border: Border.symmetric(
                                vertical: BorderSide(
                                    color:
                                        AppColors.bluecolorobacity,
                                    width: 5.w))),
                        child: Text(
                          "${'آية'} | ${arabicNumbers.convert(ayah.ayahNumber)}",
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 14,
                              fontFamily: 'kufi',
                              fontStyle: FontStyle.italic),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
                    child: greenContainer(
                        context,
                        30.0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                      onPressed: () {
                                        Share.share(
                                          '${ayah.ayah}\n\n${ayah.ayahNumber}\n\n',
                                        );
                                      },
                                      icon: Icon(
                                        Icons.share,
                                        color: AppColors.bluecolor,
                                        size: 20.h,
                                      ),
                                    ),
                            IconButton(
                              onPressed: () {
                                FlutterClipboard.copy('${widget.surah.name}\n\n'
                                        '${ayah.ayah}\n\n'
                                        '| ${ayah.ayahNumber} |');
                                 
                              },
                              icon: Icon(
                                Icons.copy,
                                color: AppColors.bluecolor,
                                size: 20.h,
                              ),
                            ),
                            
                          ],
                        ),
                        width: MediaQuery.sizeOf(context).width),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
