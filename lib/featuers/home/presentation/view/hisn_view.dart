import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quranapp/core/function/app_function.dart';
import 'package:quranapp/core/models/all_azkar.dart';
import 'package:quranapp/core/models/all_rwqya.dart';
import 'package:quranapp/core/utils/app_assets.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/core/widgets/azkar_item.dart';
import 'package:quranapp/core/widgets/lottie.dart';
import 'package:quranapp/core/widgets/menu_item_to_hisn.dart';
import 'package:quranapp/core/widgets/quran_azkar_item.dart';
import 'package:quranapp/core/widgets/rwqya_item.dart';
import 'package:quranapp/featuers/home/presentation/manger/azkar_cubit/azkar_cubit.dart';
import 'package:quranapp/featuers/home/presentation/manger/quran_azkar_cubit/quran_azkar_cubit.dart';

class HisnView extends StatelessWidget {
  const HisnView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bluecolorobacity,
        body: Stack(
          children: [
            Positioned(
              child: Image.asset(
                AppAssets.imagemuslimpray,
                fit: BoxFit.fill,
                height: 0.5.sh,
                width: double.infinity,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
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
                    ],
                  ),
                ),
                SizedBox(height: 2.sh / 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.bluecolor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        ),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MenuItemToHisn(
                                onTap: () {
                                  AppFunctions.screenModalBottomSheet(
                                      context, hisnListBuild(context));
                                },
                                icon: FlutterIslamicIcons.muslim,
                                label: 'حصن المسلم',
                              ),
                              MenuItemToHisn(
                                onTap: () {
                                  AppFunctions.screenModalBottomSheet(
                                      context, rwqyaBuild(context));
                                },
                                icon: FlutterIslamicIcons.family,
                                label: 'الرقية الشرعية',
                              ),
                              MenuItemToHisn(
                                onTap: () {
                                  AppFunctions.screenModalBottomSheet(
                                      context, quranAzkarBuild(context));
                                },
                                icon: FlutterIslamicIcons.quran2,
                                label: ' ألاذكار من القرآن',
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget quranAzkarBuild(BuildContext context) {
  return BlocBuilder<QuranAzkarCubit, QuranAzkarState>(
    builder: (context, state) {
      if (state is QuranAzkarLoaded) {
        return AnimationLimiter(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6.5,
                crossAxisSpacing: 6.5,
                childAspectRatio: 1.5,
              ),
              itemCount: state.surahs.length,
              itemBuilder: (context, index) {
                final surah = state.surahs[index];
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 450),
                  columnCount: 3,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () => AppFunctions.screenModalBottomSheet(
                          color: AppColors.bluecolor,
                          context,
                          QuranAzkarView(surah: surah),
                        ),
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                            color: AppColors.bluecolorobacity,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              surah.name,
                              style: AppTextStyles.vexatext18style,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else if (state is QuranAzkarError) {
        return Center(child: Text(state.message));
      } else {
        return Center(child: circleLoading(150.0, 150.0));
      }
    },
  );
}

Widget rwqyaBuild(BuildContext context) {
  // ColorStyle colorStyle = ColorStyle(context);
  return AnimationLimiter(
    child: Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0).r,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: allRwqyaDetails.length,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 450),
              child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                      child: Container(
                    height: 50.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppColors.bluecolorobacity),
                    child: InkWell(
                      onTap: () {
                        AppFunctions.screenModalBottomSheet(
                            context,
                            RwqyaItem(
                              rwqya: allRwqyaDetails[index].toString().trim(),
                            ));
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ).r,
                              child: Text(
                                textAlign: TextAlign.right,
                                allRwqyaDetails[index].toString(),
                                style: AppTextStyles.vexatext18style,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))));
        },
      ),
    ),
  );
}

Widget hisnListBuild(BuildContext context) {
  // ColorStyle colorStyle = ColorStyle(context);
  return AnimationLimiter(
    child: Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0).r,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        controller: AzkarCubit.get(context).controller,
        itemCount: azkarDataList.length,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 450),
              child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                      child: Container(
                    height: 50.h,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: AppColors.bluecolorobacity),
                    child: InkWell(
                      onTap: () {
                        AppFunctions.screenModalBottomSheet(
                            context,
                            AzkarItem(
                              azkar: azkarDataList[index].toString().trim(),
                            ));
                      },
                      child: Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ).r,
                          child: Text(
                            azkarDataList[index].toString(),
                            style: AppTextStyles.vexatext18style,
                            softWrap: true,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ))));
        },
      ),
    ),
  );
}
