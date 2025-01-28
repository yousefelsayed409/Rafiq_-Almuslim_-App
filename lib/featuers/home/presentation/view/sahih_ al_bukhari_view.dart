import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quranapp/core/function/app_function.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/core/widgets/custom_navigation.dart';
import 'package:quranapp/core/widgets/lottie.dart';
import 'package:quranapp/featuers/home/data/model/sahih_model.dart';
import 'package:quranapp/featuers/home/presentation/view/widget/book_sahih_widget.dart';

import '../manger/Books_cubit/books_cubit.dart';

class SahihalBukhariView extends StatelessWidget {
  const SahihalBukhariView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<SahihBukhariModels>> classesFuture = context.read<BooksCubit>().getAllSahihAlBukhari();

    return Scaffold(
     
      body: Container(
        color: AppColors.coloBackHadith2,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0).r,
      child: FutureBuilder<List<SahihBukhariModels>>(
        future: classesFuture,
        builder: (BuildContext context, AsyncSnapshot<List<SahihBukhariModels>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
              child: circleLoading(150.0, 150.0),
            );
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
                      borderRadius: const BorderRadius.all(Radius.circular(8)).r,
                      color: AppColors.coloBackHadith1,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ).r,
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
                              color: AppColors.black,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<BooksCubit>().sahihselectClass(classes [index]);
                    NavigationHelper.navigateTo(context, BooksSahihWidget());
                    // AppFunctions.screenModalBottomSheet(
                    //   color: AppColors.coloBackHadith2,
                    //   context,
                    //   // Text("data")
                    //  BooksSahihWidget(),
                    // );
                  },
                ),
              ),
            );
          }
        },
      ),
    ),
    );
  }
}
