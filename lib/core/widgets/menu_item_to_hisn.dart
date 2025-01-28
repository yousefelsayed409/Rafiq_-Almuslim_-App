import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';

class MenuItemToHisn extends StatelessWidget {
  final IconData icon;
  final String label;
    final Color ?colorIcon;

  final void Function()? onTap;

  const MenuItemToHisn({required this.icon, required this.label, this.onTap,
  this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: onTap,
            child: Container(
              
              decoration: BoxDecoration(
                
                  borderRadius: BorderRadius.circular(16),
                  // color: const Color(0xff91AFD5).withOpacity(0.4)
                  ),
              padding: const EdgeInsets.all(16),
              child: Icon(icon, size: 35.h, color:  colorIcon ?? AppColors.bluecolor),
            ),
          ),
        ),
        Text(
          label,
          style:AppTextStyles.vexatextstyle,
       
          maxLines: 1,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
