import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/colors.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> passKey = GlobalKey();

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
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Forgot password",
                style: GoogleFonts.poppins(
                    fontSize: 28.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "No Worries! Enter your email address below and we will send you a code to reset password.",
              style: GoogleFonts.poppins(fontSize: 12.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "E-mail",
              style: GoogleFonts.poppins(fontSize: 16.sp),
            ),
            SizedBox(
              height: 5.h,
            ),
            TextFormField(
              key: passKey,
              controller: emailController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: kColorTextfieldBordered, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kColorLightBlack, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: kColorPrimary,
                  fillColor: Colors.white,
                  hintText: "Enter your email",
                  hintStyle: GoogleFonts.poppins(
                      color: kColorLightBlack, fontSize: 16.sp)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Email";
                }
                return null;
              },
            ),
            // SizedBox(
            //   height: 380.h,
            // ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (passKey.currentState!.validate()) {}
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 50.w, right: 50.w, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  "Send Reset Instruction",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: kColorWhite),
                )),
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
