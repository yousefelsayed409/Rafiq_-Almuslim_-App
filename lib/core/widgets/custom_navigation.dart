import 'package:flutter/material.dart';

class NavigationHelper {
  
  // الانتقال إلى صفحة جديدة
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  // الانتقال مع إزالة جميع الصفحات السابقة
  static void navigateAndFinish(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
      (Route<dynamic> route) => false,
    );
  }

  // الانتقال إلى صفحة باسمها المعرف في الـ routes
  static void navigateToPushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  // استبدال الصفحة الحالية بصفحة جديدة
  static void navigateReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  // استبدال الصفحة الحالية بصفحة جديدة عن طريق اسمها المعرف في الـ routes
  static void navigateReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  // الانتقال مع إرسال بيانات (arguments) إلى الصفحة الجديدة
  static void navigateToWithArguments(
      BuildContext context, String routeName, Object arguments) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  // استبدال الصفحة الحالية بصفحة جديدة مع إرسال بيانات (arguments)
  static void navigateReplacementWithArguments(
      BuildContext context, String routeName, Object arguments) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  // الانتقال إلى صفحة جديدة وانتظار النتيجة منها
  static Future<T?> navigateAndReturnResult<T>(
      BuildContext context, Widget widget) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  // الانتقال عن طريق اسم المعرف وانتظار النتيجة
  static Future<T?> navigateNamedAndReturnResult<T>(
      BuildContext context, String routeName) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
    );
  }

  // العودة إلى الصفحة السابقة
  static void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  // العودة إلى الصفحة السابقة مع إرسال بيانات
  static void navigateBackWithData<T>(BuildContext context, T result) {
    Navigator.pop(context, result);
  }

  // الانتقال إلى أول صفحة في الـ Navigator (العودة إلى الصفحة الرئيسية)
  static void navigateToFirstPage(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // العودة بعد عدد معين من الصفحات
  static void navigateBackMultipleTimes(BuildContext context, int count) {
    int counter = 0;
    Navigator.popUntil(context, (route) {
      return counter++ == count;
    });
  }
}
