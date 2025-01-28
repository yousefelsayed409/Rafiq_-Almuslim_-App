import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/widgets/azkar_item.dart';
import 'package:quranapp/core/widgets/lists.dart';
import 'package:quranapp/core/widgets/lottie.dart';
import 'package:quranapp/core/widgets/widgets.dart';

import '../../manger/Books_cubit/books_cubit.dart';


class BooksSahihWidget extends StatefulWidget {
  @override
  State<BooksSahihWidget> createState() => _BooksSahihWidgetState();
}

class _BooksSahihWidgetState extends State<BooksSahihWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.coloBackHadith1,
          body: Container(
            decoration: BoxDecoration(
                color: AppColors.coloBackHadith1,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)).r),
            child: orientation(
                context,
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0).r,
                        child: buildSahihbukahri(context),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customClose(context),
                            fontSizeDropDown(context, setState,
                                AppColors.black),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 48.0).r,
                        child: buildSahihbukahri(context),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: Column(
                          children: [
                            customClose(context),
                            fontSizeDropDown(context, setState,
                            
                                AppColors.black),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))),
        )
      ),
    );
  }

  Widget buildSahihbukahri(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is SahihSelected) {
          return Padding(
            padding: orientation(context, const EdgeInsets.only(top: 30.0).r,
                const EdgeInsets.only(top: 16.0).r),
            child: PageView.builder(
                itemCount: state.sahihselectedClass.pages.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: (index % 2 == 0
                        ? rightPage(
                            context,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)
                                  .r,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(children: [
                                      WidgetSpan(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          state.sahihselectedClass.pages[index]
                                                      .title ==
                                                  ''
                                              ? Container()
                                              : greenContainer(
                                                colors:AppColors.coloBackHadith2 ,
                                                  context,
                                                  80.0,
                                                  
                                                  Container(
                                                    alignment: Alignment.center,
                                                    // width: 270,
                                                    margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 8.0,
                                                            horizontal: 32.0)
                                                        .r,
                                                    child: Text(
                                                      state.sahihselectedClass
                                                          .pages[index].title,
                                                      style: const TextStyle(
                                                          color: AppColors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'naskh',
                                                          height: 1.5),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                ),
                                          const Divider(
                                            color:AppColors.coloBackHadith2,
                                          ),
                                        ],
                                      )),
                                      TextSpan(
                                        text: state
                                            .sahihselectedClass.pages[index].text,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: AzkarItem.fontSizeAzkar,
                                            fontFamily: 'naskh',
                                            fontStyle: FontStyle.italic),
                                      ),
                                      
                                    ]),
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.visible,
                                    // showCursor: true,
                                    // cursorWidth: 3,
                                    // cursorColor: Theme.of(context).dividerColor,
                                    // cursorRadius: const Radius.circular(5),
                                    // scrollPhysics: const ClampingScrollPhysics(),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 32.0),
                                  //     child: Text(
                                  //       state.selectedClass.pages[index]
                                  //           .pageNumber,
                                  //       style: TextStyle(
                                  //         color: AppColors.black,
                                  //         fontSize: 18,
                                  //         fontFamily: 'kufi',
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )
                        : leftPage(
                            context,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)
                                  .r,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text.rich(
                                    TextSpan(children: [
                                      WidgetSpan(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          state.sahihselectedClass.pages[index]
                                                      .title ==
                                                  ''
                                              ? Container()
                                              : greenContainer(
                                                colors:AppColors.coloBackHadith2 ,
                                                  context,
                                                  80.0,
                                                  Container(
                                                    alignment: Alignment.center,
                                                    // width: 270,
                                                    margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 8.0,
                                                            horizontal: 32.0)
                                                        .r,
                                                    child: Text(
                                                      state.sahihselectedClass
                                                          .pages[index].title,
                                                      style: const TextStyle(
                                                          color: AppColors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'naskh',
                                                          height: 1.5),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                ),
                                          const Divider(
                                            color:AppColors.coloBackHadith2,
                                          ),
                                        ],
                                      )),
                                      TextSpan(
                                        text: state
                                            .sahihselectedClass.pages[index].text,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: AzkarItem.fontSizeAzkar,
                                            fontFamily: 'naskh',
                                            fontStyle: FontStyle.italic),
                                      ),
                                      
                                    ]),
                                    textAlign: TextAlign.justify,
                                    // showCursor: true,
                                    // cursorWidth: 3,
                                    // cursorColor: Theme.of(context).dividerColor,
                                    // cursorRadius: const Radius.circular(5),
                                    // scrollPhysics: const ClampingScrollPhysics(),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 32.0),
                                  //     child: Text(
                                  //       state.selectedClass.pages[index]
                                  //           .pageNumber,
                                  //       style: TextStyle(
                                  //         color: AppColors.black,
                                  //         fontSize: 18,
                                  //         fontFamily: 'kufi',
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )),
                  );
                }),
          );
        } else {
          return Center(child: circleLoading(200.0.r, 200.0.r));
        }
      },
    );
  }
}
