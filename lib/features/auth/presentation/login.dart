import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/theme/routes/app_router.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginbloc.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginevent.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginstate.dart';
import '../../../core/common/widget/snackbar_widget.dart';
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

  // void loginUser(context) async {
  //   // signUp user using our authMethod
  //   String res = await AuthMethod().loginUser(
  //       email: emailController.text, password: passwordController.text);

  //   if (res == "success") {
  //     // navigate to the home screen
  //     AutoRouter.of(context).push(const HomeScreenRoute());
  //     emailController.clear();
  //     passwordController.clear();
  //   } else {
  //     // show error
  //     showSnackBar(context, "User not found");
  //   }
  // }
  void clearController() {
    emailController.clear();
    passwordController.clear();
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
                style: GoogleFonts.poppins(
                    fontSize: 28.sp, fontWeight: FontWeight.w800),
              )),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "E-mail",
                style: GoogleFonts.poppins(fontSize: 16.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: kColorTextfieldBordered, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: kColorWhite,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: kColorLightBlack, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintStyle: GoogleFonts.poppins(
                        color: kColorLightBlack, fontSize: 16.sp)),
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
              Text(
                "Password",
                style: GoogleFonts.poppins(fontSize: 16.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                obscureText: unshowpass,
                obscuringCharacter: "*",
                controller: passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: kColorTextfieldBordered, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: kColorWhite,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kColorLightBlack, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          unshowpass = !unshowpass;
                        });
                        toggleicon();
                      },
                      child: toggleicon()),
                  hintStyle: GoogleFonts.poppins(
                      color: kColorLightBlack, fontSize: 16.sp),
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
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context)
                          .push(const ForgotPasswordScreenRoute());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.blue[500]!))),
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(
                            color: Colors.blue[500], fontSize: 16.sp),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    AutoRouter.of(context).push(const HomeScreenRoute());
                    clearController();
                  } else if (state is LoginFailure) {
                    showSnackBar(context, "Login fail");
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      if (loginKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(IsUserPresent(
                            email: emailController.text,
                            password: passwordController.text));
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
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: kColorWhite),
                      )),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 280.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.poppins(
                        color: kColorLightBlack, fontSize: 16.sp),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.blue[500]!))),
                    child: GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).push(const SignUpScreenRoute());
                        clearController();
                      },
                      child: Text(
                        "Signup",
                        style: GoogleFonts.poppins(
                            color: Colors.blue[500], fontSize: 16.sp),
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
