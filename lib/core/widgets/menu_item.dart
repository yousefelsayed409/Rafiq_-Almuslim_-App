import 'package:flutter/material.dart';
import 'package:quranapp/core/utils/app_color.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function()? onTap;

  const MenuItem({required this.icon, required this.label, this.onTap});

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
                  color: Color(0xff029D65).withOpacity(0.4)),
              padding: EdgeInsets.all(16),
              child: Icon(icon, size: 40, color: AppColors.green),
            ),
          ),
        ),
        Text(
          label,
          style:
           Theme.of(context).textTheme.bodySmall?.copyWith(
            fontFamily: 'vexa',
            color: AppColors.black),
          maxLines: 2,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
 
 