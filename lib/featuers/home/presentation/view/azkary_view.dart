// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:provider/provider.dart';
// import 'package:quranapp/core/models/all_azkar.dart';
// import 'package:quranapp/core/utils/app_color.dart';
// import 'package:quranapp/core/utils/app_styles.dart';
// import 'package:quranapp/core/widgets/azkar_item.dart';
// import 'package:quranapp/core/widgets/lists.dart';
// import 'package:quranapp/core/widgets/lottie.dart';
// import 'package:quranapp/core/widgets/widgets.dart';
// import 'package:quranapp/featuers/home/presentation/manger/azkar_cubit/azkar_cubit.dart';
// import 'package:quranapp/featuers/home/presentation/view/widget/books_view.dart';
// import 'package:quranapp/featuers/home/presentation/view/widget/boxs_page.dart';

// import '../../data/model/calss_model.dart';
// import '../manger/Books_cubit/books_cubit.dart';

// class AzkaryView extends StatelessWidget {
//   const AzkaryView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Wrap(
//           alignment: WrapAlignment.center,
//           children: [ 
//             Padding(
//               padding: const EdgeInsets.all( 8.0),
//               child: bookBanner(context),
//             ),
            
//                         book(
//                           context,
//                           booksDetails[1].title,
//                           BooksPage(
//                             title: booksDetails[1].title,
//                             details: booksDetails[1].details,
//                             myWidget: hisnListBuild(context),
//                           ),
//                         ),
//                         book(
//                           context,
//                           booksDetails[2].title,
//                           BooksPage(
//                             title: booksDetails[2].title,
//                             details: booksDetails[2].details,
//                             myWidget: booksBuild(context),
//                           ),
//                         ),
//           ],
//         ),
//       ),
//     );
//   }

// Widget bookBanner(BuildContext context) {
//   // bool screenWidth = MediaQuery.sizeOf(context).width < 400;
//   return CarouselSlider(
//     options: CarouselOptions(

//       height: 150.0.h,
//       aspectRatio: 16 / 9,
//       viewportFraction: 0.8,
//       initialPage: 0,
//       enableInfiniteScroll: true,
//       reverse: false,
//       autoPlay: true,
//       autoPlayInterval: const Duration(seconds: 7),
//       autoPlayAnimationDuration: const Duration(milliseconds: 800),
//       autoPlayCurve: Curves.fastOutSlowIn,
//       enlargeCenterPage: true,
//       enlargeFactor: 0.3,
//       scrollDirection: Axis.horizontal,
//     ),
//     items: booksDetails.map((i) {
//       return Builder(
//         builder: (BuildContext context) {
//           return Stack(
//             children: [
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: container(context, Container(), false,
//                     height: 100.0.h,
//                     width: MediaQuery.sizeOf(context).width,
//                     color: AppColors.greenOpacity),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Row(
//                   children: [
//                     Expanded(
//                         flex: 6,
//                         child: Container(
//                           height: 180.w,
//                           width: orientation(context, 150.w, 90.w),
//                           alignment: Alignment.center,
//                           margin: const EdgeInsets.all(16.0),
//                           padding: const EdgeInsets.only(top: 32.0),
//                           child: Text(
//                             i.details,
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               fontFamily: 'naskh',
//                               fontWeight: FontWeight.bold,
//                               color: Theme.of(context).colorScheme.surface,
//                             ),
//                             textAlign: TextAlign.right,
//                           ),
//                         )),
//                     Container(
//                       height: 110.h,
//                       width: 70.h,
//                       margin: const EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(boxShadow: [
//                         BoxShadow(
//                             color: Theme.of(context)
//                                 .primaryColorDark
//                                 .withOpacity(.5),
//                             offset: const Offset(0, 10),
//                             blurRadius: 10)
//                       ]),
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           book_cover(),
//                           Transform.translate(
//                             offset: const Offset(0, 10),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Text(
//                                 i.title,
//                                 style: TextStyle(
//                                   fontSize: 12.sp,
//                                   fontFamily: 'kufi',
//                                   fontWeight: FontWeight.bold,
//                                   color: Theme.of(context).canvasColor,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     }).toList(),
//   );
// }


// Widget booksBuild(BuildContext context) {
//   Future<List<Class>> classesFuture = context.read<BooksCubit>().getClasses();
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0).r,
//     child: FutureBuilder<List<Class>>(
//       future: classesFuture,
//       builder: (BuildContext context, AsyncSnapshot<List<Class>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: bookLoading(150.0, 150.0));
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error.toString()}'));
//         } else {
//           var classes = snapshot.data;

//           return AnimationLimiter(
//             child: ListView.separated(
//               itemCount: classes!.length,
//               separatorBuilder: (context, index) => const Divider(),
//               itemBuilder: (context, index) => GestureDetector(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(8)).r,
//                     color: (index % 2 == 0
//                         ? Theme.of(context).canvasColor.withOpacity(.6)
//                         : Theme.of(context).colorScheme.background),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                           horizontal: 16.0, vertical: 4.0)
//                       .r,
//                   child: AnimationConfiguration.staggeredGrid(
//                     position: index,
//                     duration: const Duration(milliseconds: 450),
//                     columnCount: 3,
//                     child: SlideAnimation(
//                       verticalOffset: 50.0,
//                       child: FadeInAnimation(
//                         child: Text(
//                           classes[index].title,
//                           style: AppTextStyles.kufi16Style
                          
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   context.read<BooksCubit>().selectClass(classes[index]);
//                   screenModalBottomSheet(context, BooksView());
//                 },
//               ),
//             ),
//           );
//         }
//       },
//     ),
//   );
// }



//   Widget hisnListBuild(BuildContext context) {
//   // ColorStyle colorStyle = ColorStyle(context);
//   return AnimationLimiter(
//     child: Container(
//       width: MediaQuery.sizeOf(context).width,
//       padding: const EdgeInsets.all(16.0).r,
//       child: ListView.separated(
//         controller: AzkarCubit.get(context).controller,
//         itemCount: azkarDataList.length,
//         padding: EdgeInsets.zero,
//         separatorBuilder: (context, index) => const Divider(),
//         itemBuilder: (BuildContext context, int index) {
//           return AnimationConfiguration.staggeredList(
//               position: index,
//               duration: const Duration(milliseconds: 450),
//               child: SlideAnimation(
//                   verticalOffset: 50.0,
//                   child: FadeInAnimation(
//                       child: Container(
//                     height: 50.h,
//                     decoration: BoxDecoration(
                      
//                       borderRadius: const BorderRadius.all(Radius.circular(8)),
//                       color: AppColors.black
//                       // (index % 2 == 0
//                       //     ? Theme.of(context).canvasColor.withOpacity(.6)
//                       //     : Theme.of(context).colorScheme.background),
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         screenModalBottomSheet(
//                             context,
//                             AzkarItem(
//                               azkar: azkarDataList[index].toString().trim(),
//                             )
//                             );
//                       },
//                       child: Row(
//                         children: [
//                           Flexible(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 8,
//                               ).r,
//                               child: Text(
//                                 azkarDataList[index].toString(),
//                                 style: TextStyle(
//                                   color: AppColors.green,
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'vexa',
//                                 ),
//                                 softWrap: true,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ))));
//         },
//       ),
//     ),
//   );
// }
//   Widget book(BuildContext context, String title, var widget) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//     child: GestureDetector(
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             height: 80.h,
//             width: 100.h,
//             decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surface,
//                 borderRadius: const BorderRadius.all(Radius.circular(8)).r),
//           ),
//           Container(
//             height: 100.h,
//             width: 60.h,
//             margin: const EdgeInsets.all(16.0).r,
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                   color: Theme.of(context).primaryColorDark.withOpacity(.5),
//                   offset: const Offset(0, 10),
//                   blurRadius: 10)
//             ]),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 book_cover(),
//                 Transform.translate(
//                   offset: const Offset(0, 10),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0).r,
//                     child: Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 11.sp,
//                         fontFamily: 'kufi',
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).canvasColor,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//       onTap: () {
//         screenModalBottomSheet(context, widget);
//       },
//     ),
//   );
// }


// }