import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/models/azkar_by_category.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/core/widgets/lists.dart';
import 'package:quranapp/core/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';

class AzkarItem extends StatefulWidget {
  const AzkarItem({Key? key, required this.azkar}) : super(key: key);
  final String azkar;

  static double fontSizeAzkar = 18;

  @override
  State<AzkarItem> createState() => _AzkarItemState();
}

class _AzkarItemState extends State<AzkarItem> {
  AzkarByCategory azkarByCategory = AzkarByCategory();
  double lowerValue = 18.sp;
  double upperValue = 40.sp;
  String? selectedValue;

  @override
  void initState() {
    azkarByCategory.getAzkarByCategory(widget.azkar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.bluecolor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ).r),
        child: orientation(
            context,
            Stack(
              children: [
                // Align(
                //     alignment: Alignment.topRight,
                //     child: customClose(context)),
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
                          Container(
                            width: 250.w,
                            alignment: Alignment.center,
                            child: Text(
                                azkarByCategory.azkarList.first.category!,
                                style: AppTextStyles.vexatext18style),
                          ),
                          fontSizeDropDown(context, setState, AppColors.white),
                        ],
                      ),
                      width: MediaQuery.sizeOf(context).width,
                    ),
                  ),
                ),
                Padding(
                  padding: orientation(
                      context,
                      const EdgeInsets.only(top: 60).r,
                      const EdgeInsets.only(top: 55).r),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: azkarBuild(context)),
                ),
              ],
            ),
            Stack(
              children: [
                // Align(
                //     alignment: Alignment.topRight, child: customClose(context)),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0).r,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        fontSizeDropDown(context, setState, AppColors.white),
                        greenContainer(
                            context,
                            100.0.h,
                            Container(
                              child: Text(
                                azkarByCategory.azkarList.first.category!,
                                style: AppTextStyles.vexatext18style,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            width:
                                MediaQuery.sizeOf(context).width / 1 / 2 * .5),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width / 1 / 2 * .9,
                        child: azkarBuild(context))),
              ],
            )),
      ),
    );
  }

  Widget azkarBuild(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: azkarByCategory.azkarList.map((azkar) {
          return Column(
            children: [
              ClipRRect(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: AppColors.bluecolorobacity,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ).r,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8).r,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                            child: Text(
                              azkar.zekr!,
                              style: AppTextStyles.naskh22.copyWith(
                                color: AppColors.black,

                                  fontSize: AzkarItem.fontSizeAzkar,
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8).r,
                            margin: const EdgeInsets.symmetric(horizontal: 8).r,
                            decoration: BoxDecoration(
                                color: AppColors.bluecolorobacity,
                                border: Border.symmetric(
                                    vertical: BorderSide(
                                        color: AppColors.bluecolorobacity,
                                        width: 5.w))),
                            child: Text(
                              azkar.reference!,
                              style: TextStyle(
                                color: AppColors.black,
                                  fontSize: AzkarItem.fontSizeAzkar,
                                fontFamily: 'kufi',
                                fontStyle: FontStyle.italic,
                              ),
                            )),
                      ),
                      azkar.description! == ''
                          ? Container()
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8)
                                      .r,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8)
                                          .r,
                                  decoration: BoxDecoration(
                                      color: AppColors.bluecolorobacity,
                                      border: Border.symmetric(
                                          vertical: BorderSide(
                                              color: AppColors.bluecolorobacity,
                                              width: 5.w))),
                                  child: Text(
                                    azkar.description!,
                                    style: TextStyle(
                                        color: AppColors.black,
                                          fontSize: AzkarItem.fontSizeAzkar,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Share.share(
                                          '${azkar.category}\n\n${azkar.zekr}\n\n| ${azkar.description}. | (التكرار: ${azkar.count})',
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
                                        FlutterClipboard.copy(
                                          '${azkar.category}\n\n'
                                          '${azkar.zekr}\n\n'
                                          '| ${azkar.description}. | (التكرار: ${azkar.count})',
                                        );
                                      },
                                      icon: Icon(
                                        Icons.copy,
                                        color: AppColors.bluecolor,
                                        size: 20.h,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4)
                                      .r,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ).r,
                                    color: AppColors.bluecolor,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        azkar.count!,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 14.sp,
                                            fontFamily: 'kufi',
                                            fontStyle: FontStyle.italic),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.repeat,
                                        color: AppColors.white,
                                        size: 18.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            width: MediaQuery.sizeOf(context).width),
                      ),
                      const Divider(
                        thickness: 3,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h), // Add space between items
            ],
          );
        }).toList(),
      ),
    );
  }
}
