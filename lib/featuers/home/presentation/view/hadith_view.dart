import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quranapp/core/function/app_function.dart';
import 'package:quranapp/core/models/all_hadith.dart';
import 'package:quranapp/core/utils/app_assets.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/core/widgets/custom_navigation.dart';
import 'package:quranapp/core/widgets/hadith_item.dart';
import 'package:quranapp/core/widgets/lottie.dart';
import 'package:quranapp/core/widgets/menu_item_to_hisn.dart';
import 'package:quranapp/featuers/home/data/model/calss_model.dart';
import 'package:quranapp/featuers/home/presentation/manger/Books_cubit/books_cubit.dart';
import 'package:quranapp/featuers/home/presentation/view/widget/books_view.dart';

class HadithView extends StatelessWidget {
  const HadithView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.coloBackHadith1,
        body: Stack(
          
          children: [
            Positioned(
              child: SvgPicture.asset(
                AppAssets.imagemuslim,
                fit: BoxFit.fill,
                height: 0.6.sh,
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
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.5.sh ),
                Padding(
                  padding: EdgeInsets.all(20.0.r),
                  child: Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: const BoxDecoration(
                      color: AppColors.coloBackHadith2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // alignment: WrapAlignment.center,
                      // spacing: 30.w,
                      // runSpacing: 10.h,
                      children: [
                        MenuItemToHisn(
                          onTap: () {
                          AppFunctions.  screenModalBottomSheet(
                            color: AppColors.coloBackHadith2,
                                context, hadithBuild(context));
                          },
                          icon: FlutterIslamicIcons.hadji,
                            colorIcon: AppColors.black,
                          label: ' ألأحاديث ألأربعون النووية',
                        ),
                        MenuItemToHisn(
                          icon: FlutterIslamicIcons.quran,
                          colorIcon: AppColors.black,
                          label: 'الطب النبوي',
                          onTap: () {
                          AppFunctions.  screenModalBottomSheet(
                            color: AppColors.coloBackHadith2,
                                context, booksBuild(context));
                          },
                        ),
                       
                        
                      ],
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
// void screenModalBottomSheet(BuildContext context, Widget child) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//     ),
//     builder: (BuildContext context) {
//       return Container(
//         decoration: BoxDecoration(
//           color: AppColors.coloBackHadith2,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: EdgeInsets.all(16.r),
//         height: MediaQuery.of(context).size.height * 0.85,
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child:      customClose(context),
//             ),
//             Expanded(child: child),
//           ],
//         ),
//       );
//     },
//   );
// }

Widget booksBuild(BuildContext context) {
  Future<List<Class>> classesFuture = context.read<BooksCubit>().getClasses();
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0).r,
    child: FutureBuilder<List<Class>>(
      future: classesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Class>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(child: circleLoading(150.0, 150.0));
          // return Center(child: bookLoading(150.0, 150.0));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        } else {
          var classes = snapshot.data;

          return AnimationLimiter(
            child: ListView.separated(
                      physics: const BouncingScrollPhysics(),

              itemCount: classes!.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8)).r,
                      color: AppColors.coloBackHadith1),
                  padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0)
                      .r,
                  child: AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 450),
                    columnCount: 3,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Text(
                          textAlign: TextAlign.right,
                          classes[index].title,
                          style: AppTextStyles.vexatext18style.copyWith(
                            fontSize: 16,
                            color: AppColors.black
                          ),
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  context.read<BooksCubit>().selectClass(classes[index]);
                  NavigationHelper.navigateTo(context, BooksView());
                // AppFunctions.  screenModalBottomSheet(
                //   color: AppColors.coloBackHadith2,
                //   context, BooksView());
                },
              ),
            ),
          );
        }
      },
    ),
  );
}

Widget hadithBuild(BuildContext context) {

  return AnimationLimiter(
    child: Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0).r,
      child: ListView.separated(
                physics: const BouncingScrollPhysics(),

        itemCount: allHadithDetails.length,
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
                        borderRadius:
                            BorderRadius.all(Radius.circular(8)),
                        color: AppColors.coloBackHadith1),
                    child: InkWell(
                      onTap: () {  
                        NavigationHelper.navigateTo(context, HadithItem(
                              hadith: allHadithDetails[index].toString().trim(),
                            ));
                      //  AppFunctions. screenModalBottomSheet(
                      //   color: AppColors.coloBackHadith2,
                      //       context,
                      //       HadithItem(
                      //         hadith: allHadithDetails[index].toString().trim(),
                      //       )
                      //       );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ).r,
                              child: Text(
                                textAlign: TextAlign.right,
                                allHadithDetails[index].toString(),
                                style: AppTextStyles.vexatext18style.copyWith(
                                  color: AppColors.black
                                ),
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