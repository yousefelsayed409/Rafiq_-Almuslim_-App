import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';
import 'package:quranapp/core/widgets/widgets.dart';
import 'package:quranapp/featuers/home/data/model/asmaa_allah_model.dart';

class AsmaaAllahView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!joinedAsmaaAllahScreenBefore) {
      Future.delayed(const Duration(milliseconds: 150), () {
        onScreenOpen(context);
      });
      joinedAsmaaAllahScreenBefore = true;
    }

    return Scaffold(
      backgroundColor: AppColors.bluecolor,
      body: AnimationLimiter(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.2,  
              ),
              itemCount: AsmaaAllahElHosna.name.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    awesomeDialog(
                      
                      dialogType: DialogType.question,
                      context,
                      AsmaaAllahElHosna.name[index],
                      AsmaaAllahElHosna.meaning[index],
                    );
                  },
                  child: AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 3,
                    duration: const Duration(milliseconds: 450),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.bluecolorobacity,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              AsmaaAllahElHosna.name[index],
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
        ),
      ),
    );
  }
}