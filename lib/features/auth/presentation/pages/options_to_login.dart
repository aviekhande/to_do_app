import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/constants/constants.dart';
import 'package:to_do_app/core/theme/colors.dart';

import '../../../../core/routes/app_router.dart';

@RoutePage()
class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            SvgPicture.asset(Constants.welcome_banner),
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(const SignUpScreenRoute());
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 48.w, right: 48.w, top: 10.h, bottom: 10.h),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.surface ==
                                    Colors.grey.shade700
                                ? kColorWhite
                                : Colors.black,
                            width: 2.w),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text(
                      "Register",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(const LoginScreenRoute());
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 60.w, right: 60.w, top: 12.h, bottom: 12.h),
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
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                AutoRouter.of(context)
                    .push(const MobileNumberLoginScreenRoute());
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 50.w, right: 50.w, top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.surface ==
                                Colors.grey.shade700
                            ? kColorWhite
                            : Colors.black,
                        width: 2.w),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  "SignIn with mobile number",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp, fontWeight: FontWeight.w500),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
