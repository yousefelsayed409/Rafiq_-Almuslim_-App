// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:quranapp/core/utils/app_color.dart';
// import 'package:quranapp/core/utils/app_styles.dart';
// import 'dart:convert';

// import 'package:quranapp/featuers/home/data/model/azkar_model.dart';
// import 'package:quranapp/featuers/home/presentation/view/azkar_detail_view.dart';

// class AzkarView extends StatefulWidget {
//   const AzkarView({Key? key}) : super(key: key);

//   @override
//   _AzkarViewState createState() => _AzkarViewState();
// }

// class _AzkarViewState extends State<AzkarView> {
//   List<AzkarModel> sections = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadSections();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "أذكار المسلم",
//           style: AppTextStyles.tajawalstyle22.copyWith(
            
//             color: AppColors.black,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemBuilder: (context, index) =>
//               buildSectionItem(model: sections[index]),
//           itemCount: sections.length,
//         ),
//       ),
//     );
//   }

//   Widget buildSectionItem({required AzkarModel model}) {
//     return InkWell(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => SectionDetailScreen(
//                   id: model.id!,
//                   title: model.name!,
//                 )));
//       },
//       child: Container(
//         margin:  EdgeInsets.only(top: 12.0),
//         width: double.infinity,
//         height: 70.h,
//         decoration: BoxDecoration(
//           color: AppColors.greenOpacity.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Center(
//             child: Text(
//           "${model.name}",
//           style: AppTextStyles.tajawalstyle22,
//         )),
//       ),
//     );
//   }

//   loadSections() async {
//     DefaultAssetBundle.of(context)
//         .loadString("assets/database/sections_db.json")
//         .then((data) {
//       var response = json.decode(data);
//       response.forEach((section) {
//         AzkarModel _section = AzkarModel.fromJson(section);
//         sections.add(_section);
//       });
//       setState(() {});
//     }).catchError((error) {
//       print(error);
//     });
//   }
// }
