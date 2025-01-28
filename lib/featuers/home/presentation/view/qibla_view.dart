import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quranapp/core/widgets/custom_button.dart';
import 'package:quranapp/core/widgets/lottie.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;
  bool hasPermission = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    getPermission();
  }

  Future<void> getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        setState(() {
          hasPermission = true;
        });
      } else {
        final result = await Permission.location.request();
        setState(() {
          hasPermission = (result == PermissionStatus.granted);
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        body: hasPermission ? buildQiblahView() : buildPermissionRequest(),
      ),
    );
  }

  Widget buildQiblahView() {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: circleLoading(150.0, 150.0),
          );
        }

        final qiblahDirection = snapshot.data;
        if (qiblahDirection != null) {
          animation = Tween(begin: begin, end: (qiblahDirection.qiblah * (pi / 180) * -1)).animate(_animationController!);
          begin = (qiblahDirection.qiblah * (pi / 180) * -1);
          _animationController!.forward(from: 0);
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'اتجاه القبلة',
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "${qiblahDirection?.direction.toInt() ?? 0}°",
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: AnimatedBuilder(
                  animation: animation!,
                  builder: (context, child) => Transform.rotate(
                    angle: animation!.value,
                    child: Image.asset('assets/image/qibla.png'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'اتبع السهم للوصول إلى اتجاه القبلة الصحيح.',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPermissionRequest() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'يجب منح إذن الموقع لعرض اتجاه القبلة',
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SecondaryButton(

            title: 'إعادة المحاولة',  onPressed: () async {
              final result = await Permission.location.request();
              setState(() {
                hasPermission = (result == PermissionStatus.granted);
              });
            },),
          
          const SizedBox(height: 10),
          PrimaryButton(
            title: 'فتح إعدادات التطبيق',
            onPressed: () {
              // فتح إعدادات التطبيق
              openAppSettings();
            },
          ),
          
        ],
      ),
    );
  }
}
