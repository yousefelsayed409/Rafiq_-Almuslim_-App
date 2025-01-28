
import 'package:flutter/material.dart';
import 'package:quranapp/core/utils/app_color.dart';


class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  const PrimaryButton({super.key, required this.title, this.fontSize = 18, this.fontWeight = FontWeight.w600, required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/image/primary_btn.png"),
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: AppColors.secondary.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: AppColors.white, fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}




class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  const SecondaryButton(
      {super.key,
      required this.title,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w600,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.greenOpacity,
          // image: const DecorationImage(
          //   image: AssetImage("assets/image/secodry_btn.png"),
          // ),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: AppColors.white, fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
