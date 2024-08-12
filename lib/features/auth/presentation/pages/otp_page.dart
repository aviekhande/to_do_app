import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/common/widget/appbar_widget.dart';
import '../../../../core/theme/colors.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class OtpPage extends StatefulWidget {
  final String mobile;
  const OtpPage({super.key, required this.mobile});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController number1Controller = TextEditingController();
  TextEditingController number2Controller = TextEditingController();
  TextEditingController number3Controller = TextEditingController();
  TextEditingController number4Controller = TextEditingController();

  TextEditingController getController(int ind) {
    if (ind == 0) {
      return number1Controller;
    } else if (ind == 1) {
      return number2Controller;
    } else if (ind == 2) {
      return number3Controller;
    } else {
      return number4Controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite.w, 50.h),
          child: const CustomAppBar(
            title: "Verification",
            isBack: true,
          )),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Text(
              "Code is sent to ${widget.mobile}",
              style: GoogleFonts.poppins(
                  fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  width: 50.w,
                  height: 45.h,
                  child: TextFormField(
                    maxLength: 1,
                    controller: getController(index),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: "",
                      hintStyle: GoogleFonts.poppins(
                          color: kColorLightBlack, fontSize: 16.sp),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      hintText: "0",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Number";
                      }
                      return null;
                    },
                  ),
                );
              }),
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
                  "Verify",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: kColorWhite),
                )),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Did not receive the code",
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Text(
                    " RESEND CODE",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
