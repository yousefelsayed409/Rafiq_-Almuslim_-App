import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/models/azkar_by_category.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/core/widgets/lists.dart';
import 'package:quranapp/core/widgets/widgets.dart';
import 'package:share_plus/share_plus.dart';

class HadithItem extends StatefulWidget {
  const HadithItem({Key? key, required this.hadith}) : super(key: key);
  final String hadith;

  static double fontSizeAzkar = 18;

  @override
  State<HadithItem> createState() => _HadithItemState();
}

class _HadithItemState extends State<HadithItem> {
  AzkarByCategory hadithByCategory = AzkarByCategory();
  double lowerValue = 18.sp;
  double upperValue = 40.sp;
  String? selectedValue;

  @override
  void initState() {
    hadithByCategory.getHadithByCategory(widget.hadith);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.coloBackHadith2,
          body: Container(
          decoration: BoxDecoration(
              color: AppColors.coloBackHadith1,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ).r),
          child: orientation(
              context,
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0).r,
                      child: greenContainer(
                      colors: AppColors.coloBackHadith2,
                        context,
                        32.0.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customClose(context),
                            Container(
                              width: 250.w,
                              alignment: Alignment.center,
                              child: Text(
                                hadithByCategory.hadithList.isNotEmpty
                                    ? hadithByCategory.hadithList.first.nameHadith
                                    : "لا توجد بيانات",
                                style: AppTextStyles.vexatext18style,
                              ),
                            ),
                            fontSizeDropDowntow(context, setState, AppColors.black),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0).r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          fontSizeDropDowntow(context, setState, AppColors.black),
                          greenContainer(
                            context,
                            100.0.h,
                            Container(
                              child: Text(
                                hadithByCategory.hadithList.isNotEmpty
                                    ? hadithByCategory.hadithList.first.nameHadith
                                    : "لا يوجد حديث",
                                style: AppTextStyles.vexatext18style,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            width: MediaQuery.sizeOf(context).width / 1 / 2 * .5,
                          ),
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
        )
      ),
    );
  }

  Widget azkarBuild(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: hadithByCategory.hadithList.isNotEmpty
            ? hadithByCategory.hadithList.map((hadith) {
                return Column(
                  children: [
                    ClipRRect(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: AppColors.coloBackHadith1,
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
                                      color: AppColors.coloBackHadith1,
                                      width: 5.w,
                                    ),
                                  ),
                                ),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8).r,
                                  child: Text(
                                    hadith.textHadith,
                                    style: AppTextStyles.naskh22.copyWith(
                                      color: AppColors.black,
                                      fontSize: HadithItem.fontSizeAzkar,
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
                                      color: AppColors.coloBackHadith2,
                                      border: Border.symmetric(
                                          vertical: BorderSide(
                                              color: AppColors.coloBackHadith1,
                                              width: 5.w))),
                                  child: Text(
                                    hadith.explanationHadith,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: HadithItem.fontSizeAzkar,
                                      fontFamily: 'naskh',
                                      
                                    ),
                                  )),
                            ),
                            hadith.translateNarrator == ''
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
                                            color: AppColors.coloBackHadith2,
                                            border: Border.symmetric(
                                                vertical: BorderSide(
                                                    color: AppColors.coloBackHadith1,
                                                    width: 5.w))),
                                        child: Text(
                                          hadith.translateNarrator,
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: HadithItem.fontSizeAzkar,
                                            fontFamily: 'kufi',
                                            fontStyle: FontStyle.italic,
                                          ),
                                        )),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
                              child: greenContainer(
                                colors: AppColors.coloBackHadith1,
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
                                                '${hadith.key}\n\n${hadith.nameHadith}\n\n| ${hadith.textHadith}. |  ${hadith.explanationHadith}. |  ${hadith.translateNarrator})',
                                              );
                                            },
                                            icon: Icon(
                                              Icons.share,
                                              color: AppColors.black,
                                              size: 20.h,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              FlutterClipboard.copy(
                                                '${hadith.key}\n\n'
                                                '${hadith.nameHadith}\n\n'
                                             '${hadith.textHadith}\n\n'
                                             '${hadith.explanationHadith}\n\n'
                                             '${hadith.translateNarrator}\n\n',


                                                
                                              );
                                            },
                                            icon: Icon(
                                              Icons.copy,
                                              color: AppColors.black,
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
                                          color: AppColors.coloBackHadith1,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              hadith.key,
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'kufi',
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            const SizedBox(
                                              width: 5,
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
              }).toList()
            : [const Text("لا يوجد حديث لعرضه")],
      ),
    );
  } 



  
}
