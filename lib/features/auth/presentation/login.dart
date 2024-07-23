import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/theme/routes/app_router.dart';

import '../../../core/theme/colors.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool unshowpass = true;
  Icon toggleicon() {
    return Icon(
        unshowpass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 100.h, right: 15.w, left: 15.w),
        child: Form(
          key: loginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                "Login",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w800),
              )),
              SizedBox(
                height: 10.h,
              ),
              const Text("E-mail"),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    focusColor: kColorPrimary,
                    fillColor: kColorLightBlack,
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintStyle: const TextStyle(color: kColorLightBlack)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text("Password"),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                obscureText: unshowpass,
                obscuringCharacter: "*",
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          unshowpass = !unshowpass;
                        });
                        toggleicon();
                      },
                      child: toggleicon()),
                  hintStyle: const TextStyle(color: kColorLightBlack),
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 20, top: 8, right: 10),
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Password";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.blue[500]!))),
                    child: Text(
                      "Forgot Password?",
                      style:
                          TextStyle(color: Colors.blue[500], fontSize: 14.sp),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  if (loginKey.currentState!.validate()) {
                    AutoRouter.of(context).push(const HomeScreenRoute());
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 50.w, right: 50.w, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: kColorWhite),
                  )),
                ),
              ),
              SizedBox(
                height: 180.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: kColorLightBlack, fontSize: 18.sp),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.blue[500]!))),
                    child: GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).push(const SignUpScreenRoute());
                      },
                      child: Text(
                        "Signup",
                        style:
                            TextStyle(color: Colors.blue[500], fontSize: 18.sp),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
