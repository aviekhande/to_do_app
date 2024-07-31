import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/core/common/widget/bottomnav_widget.dart';
import 'package:to_do_app/features/auth/presentation/pages/login.dart';
import 'package:to_do_app/features/home_screen/presentation/pages/home_screen.dart';

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
                  ? const HomeScreenRoute()
                  : const LoginScreenRoute());
            }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                // child: Lottie.asset(
                //   'assets/images/Signing document.gif',
                //   fit: BoxFit.cover,
                //   width: 400,
                //   height: 400,
                //   repeat: true,
                // ),
                ),
            const Center(
              child: Text(
                "Splash Screen",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
