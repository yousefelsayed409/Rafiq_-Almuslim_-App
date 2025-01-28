// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:quranapp/core/extintion/size.dart';
// import 'package:quranapp/core/utils/app_color.dart';
// import 'package:quranapp/core/utils/app_styles.dart';
// import 'dart:convert';

// import 'package:quranapp/featuers/home/data/model/azkar_model.dart';

// class SectionDetailScreen extends StatefulWidget {
//   final int id;
//   final String title;
//   const SectionDetailScreen({Key? key, required this.id, required this.title})
//       : super(key: key);

//   @override
//   _SectionDetailScreenState createState() => _SectionDetailScreenState();
// }

// class _SectionDetailScreenState extends State<SectionDetailScreen> {
//   List<AzkarDetailModel> sectionDetails = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadSectionDetail();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "${widget.title}",
//           style: AppTextStyles.tajawalstyle20,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ListView.separated(
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Container(
//                 decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                   BoxShadow(
//                     color: Colors.green.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 2,
//                     offset: const Offset(0, 3),
//                   )
//                 ]),
//                 child: ListTile(
//                   title: Text(
//                     "${sectionDetails[index].reference}",
//                     textDirection: TextDirection.rtl,
//                     style: AppTextStyles.tajawalstyle20,
//                   ),
//                   subtitle: Text(
//                     "${sectionDetails[index].content}",
//                     textDirection: TextDirection.rtl,
//                     style: AppTextStyles.tajawalstyle20,
//                   ),
//                 ),
//               );
//             },
//             separatorBuilder: (context, index) =>
//                 const Divider(height: 3, color: AppColors.green),
//             itemCount: sectionDetails.length),
//       ),
//     );
//   }

//   loadSectionDetail() async {
//     sectionDetails = [];
//     DefaultAssetBundle.of(context)
//         .loadString("assets/database/section_details_db.json")
//         .then((data) {
//       var response = json.decode(data);
//       response.forEach((section) {
//         AzkarDetailModel _sectionDetail = AzkarDetailModel.fromJson(section);

//         if (_sectionDetail.sectionId == widget.id) {
//           sectionDetails.add(_sectionDetail);
//         }
//       });
//       setState(() {});
//     }).catchError((error) {
//       print(error);
//     });
//   }
// }
