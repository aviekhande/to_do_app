import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';
// import 'package:to_do_app/core/common/widget/bottomnav_widget.dart';
// import 'package:to_do_app/features/auth/presentation/pages/login.dart';
// import 'package:to_do_app/features/home_screen/presentation/pages/home_screen.dart';
import '../../../../core/common/widget/session_controller.dart';
import '../../../../core/routes/app_router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? isLogin() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      SessionController().userId = user.uid.toString();
    }
    return user;
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Timer(const Duration(seconds: 2), () {
              AutoRouter.of(context).replace(isLogin() != null
                  ? const CommonbottomnavigationbarRoute()
                  : const OptionScreenRoute());
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //  AnimatedSplashScreen(
      //   nextScreen: isLogin() != null
      //       ? const Commonbottomnavigationbar()
      //       : const LoginScreen(),
      backgroundColor: const Color.fromARGB(255, 214, 232, 215),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset(
              'assets/lottie/Animation - 1722508581590.json',
              height: 350.h,
              width: 350.w,
            ),
          ),
        ],
      ),
    );
  }
}
