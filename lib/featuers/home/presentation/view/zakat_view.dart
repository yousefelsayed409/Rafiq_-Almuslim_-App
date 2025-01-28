import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/utils/app_styles.dart';

class ZakatCalculatorView extends StatefulWidget {
  @override
  _ZakatCalculatorViewState createState() => _ZakatCalculatorViewState();
}

class _ZakatCalculatorViewState extends State<ZakatCalculatorView> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nisabController = TextEditingController();
  double? _zakatAmount;
  String _wealthType = 'مال';
  double _zakatPercentage = 0.025; // نسبة الزكاة الافتراضية
  final _formKey = GlobalKey<FormState>();

  void calculateZakat() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(_amountController.text) ?? 0;
      final nisab = double.tryParse(_nisabController.text) ?? 0;

      if (amount >= nisab && nisab > 0) {
        setState(() {
          _zakatAmount = amount * _zakatPercentage;
        });
      } else {
        setState(() {
          _zakatAmount = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.greenOpacity,
        title: Text('دليل الزكاة', style: AppTextStyles.tajawalstyle22),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.r),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // مقدمة عن الزكاة
              Text(
                'الزكاة هي ركن من أركان الإسلام وتجب على المسلمين بشروط معينة. وهي تطهير للنفس وتزكية للمال.',
                style:
                    AppTextStyles.kufi16Style.copyWith(color: AppColors.black),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 20.h),

              // اختيار نوع الزكاة
              Text(
                'اختر نوع الزكاة:',
                style: AppTextStyles.kufi16Style.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 10.h),

              DropdownButton<String>(
                value: _wealthType,
                onChanged: (String? newValue) {
                  setState(() {
                    _wealthType = newValue!;
                    switch (_wealthType) {
                      case 'مال':
                        _zakatPercentage = 0.025;
                        break;
                      case 'ذهب':
                        _zakatPercentage = 0.025;
                        
                        break;
                      case 'زكاة الفطر':
                        _zakatPercentage = 0.0; // زكاة الفطر ليست نسبة مئوية
                        break;
                      default:
                        _zakatPercentage = 0.025;
                    }
                  });
                },
                items: <String>['مال', 'ذهب',  'زكاة الفطر']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: AppTextStyles.kufi16Style
                            .copyWith(color: AppColors.black)),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),

              // حاسبة الزكاة
              Text(
                'حاسبة الزكاة:',
                style: AppTextStyles.kufi16Style.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),

              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'أدخل المبلغ هنا',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: AppColors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: AppColors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:
                        const BorderSide(color: AppColors.green, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال قيمة المبلغ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              TextFormField(
                controller: _nisabController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'أدخل المبلغ هنا',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: AppColors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: AppColors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide:
                        const BorderSide(color: AppColors.green, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يجب إدخال قيمة المبلغ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: calculateZakat,
                  child: Text('احسب الزكاة', style: AppTextStyles.kufi16Style),
                ),
              ),
              SizedBox(height: 20.h),

              if (_zakatAmount != null)
                Center(
                  child: _zakatAmount! > 0
                      ? Text(
                          'مقدار الزكاة: ${_zakatAmount!.toStringAsFixed(2)} ${_wealthType == 'مال' ? 'جنيه' : 'جرام'}',
                          style: AppTextStyles.kufi16Style.copyWith(
                            fontSize: 18.sp,
                            color: AppColors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          'المبلغ أقل من النصاب ولا تجب عليه الزكاة.',
                          style: AppTextStyles.kufi16Style.copyWith(
                            fontSize: 16.sp,
                            color: Colors.red,
                          ),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
