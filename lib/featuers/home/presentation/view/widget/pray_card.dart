import 'package:flutter/material.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';

class prayCard extends StatefulWidget {
  final String label;
  final String time;
  final IconData icon;

  const prayCard({required this.label, required this.icon, required this.time});

  @override
  State<prayCard> createState() => _prayCardState();
}

class _prayCardState extends State<prayCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
      margin: const EdgeInsets.all(15),
      child: ListTile(
        leading: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 1.0,
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              widget.icon,
              color: Colors.orangeAccent,
            ),
          ),
        ),
        title: Text(
          textAlign: TextAlign.center,
          widget.label,
          style: AppTextStyles.kufi16Style
              .copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          widget.time,
          style: AppTextStyles.kufi16Style
              .copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        
      ),
    );
  }
}
