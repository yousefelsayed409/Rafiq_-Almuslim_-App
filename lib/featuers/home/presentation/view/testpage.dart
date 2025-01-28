// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:provider/provider.dart';
// import 'package:quranapp/core/models/all_azkar.dart';
// import 'package:quranapp/core/models/all_rwqya.dart';
// import 'package:quranapp/core/utils/app_color.dart';
// import 'package:quranapp/core/utils/app_styles.dart';
// import 'package:quranapp/core/widgets/azkar_item.dart';
// import 'package:quranapp/core/widgets/lists.dart';
// import 'package:quranapp/core/widgets/lottie.dart';
// import 'package:quranapp/core/widgets/rwqya_item.dart';
// import 'package:quranapp/core/widgets/widgets.dart';
// import 'package:quranapp/featuers/home/data/model/calss_model.dart';
// import 'package:quranapp/featuers/home/presentation/manger/Books_cubit/books_cubit.dart';
// import 'package:quranapp/featuers/home/presentation/manger/azkar_cubit/azkar_cubit.dart';
// import 'package:quranapp/featuers/home/presentation/view/widget/books_view.dart';
// import 'package:quranapp/featuers/home/presentation/view/widget/boxs_page.dart';



// class AzkarList extends StatelessWidget {
//   const AzkarList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           backgroundColor: AppColors.white,
//           body: Padding(
//             padding:
//                 const EdgeInsets.only(
//                   top: 16,
//                   bottom: 16.0, right: 16.0, left: 16.0).r,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xffE7DFCE),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   bottomLeft: Radius.circular(8),
//                   bottomRight: Radius.circular(8),
//                 ),
//               ),
//               width: MediaQuery.sizeOf(context).width,
//               height: MediaQuery.sizeOf(context).height,
//               child: booksList(context),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget booksList(BuildContext context) {
//   return SingleChildScrollView(
//     child:  Wrap(
//           alignment: WrapAlignment.center,
//           children: [
           
            
            
//             book(
//               context,
//               booksDetails[0].title,
//               BooksPage(
//                 title: booksDetails[0].title,
//                 details: booksDetails[0].details,
//                 myWidget: hisnListBuild(context),
//               ),
//             ),
//             book(
//               context,
//               booksDetails[1].title,
//               BooksPage(
//                 title: booksDetails[1].title,
//                 details: booksDetails[1].details,
//                 myWidget: booksBuild(context),
//               ),
              
//             ),
//              book(
//               context,
//               booksDetails[2].title,
//               BooksPage(
//                 title: booksDetails[2].title,
//                 details: booksDetails[2].details,
//                 myWidget: rwqyaBuild(context),
//               ),),
//           ],
//         )
//   );
// }

// Widget book(BuildContext context, String title, var widget) {
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
//                 color: AppColors.greenOpacity,
//                 borderRadius: const BorderRadius.all(Radius.circular(8)).r),
//           ),
//           Container(
//             height: 100.h,
//             width: 60.h,
//             margin: const EdgeInsets.all(16.0).r,
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                   color: AppColors.green,
//                   offset: const Offset(0, 10),
//                   blurRadius: 10)
//             ]),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // book_cover(),
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

// Widget rwqyaBuild(BuildContext context) {
//   // ColorStyle colorStyle = ColorStyle(context);
//   return AnimationLimiter(
//     child: Container(
//       width: MediaQuery.sizeOf(context).width,
//       padding: const EdgeInsets.all(16.0).r,
//       child: ListView.separated(
//         // controller: AzkarCubit.get(context).controller,
//         itemCount: allRwqyaDetails.length,
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
                      
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         screenModalBottomSheet(
//                             context,
//                             RwqyaItem(
//                               rwqya: allRwqyaDetails[index].toString().trim(),
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
//                                 allRwqyaDetails[index].toString(),
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

