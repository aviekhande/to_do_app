import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/colors.dart';

@RoutePage()
class MobileNumberLoginScreen extends StatefulWidget {
  const MobileNumberLoginScreen({super.key});

  @override
  State<MobileNumberLoginScreen> createState() =>
      _MobileNumberLoginScreenState();
}

class _MobileNumberLoginScreenState extends State<MobileNumberLoginScreen> {
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
            ),
            SizedBox(
                height: 180.h,
                child:
                    SvgPicture.asset("assets/images/mobile_number_banner.svg")),
            SizedBox(
              height: 50.h,
            ),
            Text(
              "Enter your mobile number",
              style: GoogleFonts.poppins(
                  fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: numberController,
              decoration: InputDecoration(
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "+91",
                      style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: kColorLightBlack),
                    ),
                  ],
                ),
                hintStyle: GoogleFonts.poppins(
                    color: kColorLightBlack, fontSize: 14.sp),
                contentPadding: const EdgeInsets.only(
                    left: 15, bottom: 20, top: 8, right: 10),
                hintText: "Mobile Number",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Password";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.h,
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
                  "Continue",
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: kColorWhite),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
