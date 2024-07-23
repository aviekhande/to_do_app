import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/colors.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool unshowpass = true;
  Icon toggleicon() {
    return Icon(
        unshowpass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            AutoRouter.of(context).popForced();
          },
          child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kColorWhite,
              ),
              child: SvgPicture.asset("assets/icons/back_ic.svg")),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h, right: 15.w, left: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                "Register",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w800),
              )),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 80.h,
                      child: Image.asset("assets/images/profile_image.png"),
                    ),
                    Positioned(
                      bottom: 3,
                      left: 68,
                      child: GestureDetector(
                        onTap: () {
                          // Handle camera icon tap here
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: kColorWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 203, 202, 202),
                                    offset: Offset(0, 2),
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ]),
                          height: 30.h,
                          width: 30.w,
                          child: const Icon(
                            Icons.photo_camera_outlined,
                            color: kColorPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("First Name"),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        width: 150.w,
                        child: TextFormField(
                          obscureText: unshowpass,
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: kColorLightBlack),
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: 20, top: 8, right: 10),
                            hintText: "Jhon",
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
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Last Name"),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        width: 150.w,
                        child: TextFormField(
                          obscureText: unshowpass,
                          obscuringCharacter: "*",
                          controller: lastNameController,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: kColorLightBlack),
                            contentPadding: const EdgeInsets.only(
                                left: 15, bottom: 20, top: 8, right: 10),
                            hintText: "Doe",
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
                      ),
                    ],
                  ),
                ],
              ),
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
                height: 10.h,
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
                  hintText: "*********",
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
                height: 10.h,
              ),
              const Text("Confirm Password"),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                obscureText: unshowpass,
                obscuringCharacter: "*",
                controller: confirmPasswordController,
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
                  hintText: "**********",
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
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.only(
                      left: 50.w, right: 50.w, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: kColorWhite),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
