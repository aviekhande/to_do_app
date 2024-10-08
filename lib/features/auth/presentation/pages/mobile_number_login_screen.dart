import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/loader_widget.dart';
import 'package:to_do_app/core/common/widget/snackbar_widget.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/login_number_bloc/log_in_with_number_bloc.dart';

@RoutePage()
class MobileNumberLoginScreen extends StatefulWidget {
  const MobileNumberLoginScreen({super.key});

  @override
  State<MobileNumberLoginScreen> createState() =>
      _MobileNumberLoginScreenState();
}

class _MobileNumberLoginScreenState extends State<MobileNumberLoginScreen> {
  TextEditingController numberController = TextEditingController();
  GlobalKey<FormState> mobileKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
            onTap: () {
              AutoRouter.of(context).popForced();
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/back_ic.svg",
                  height: 25.h,
                ),
                SizedBox(
                  width: 30.w,
                ),
              ],
            )),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                    height: 180.h,
                    child: SvgPicture.asset(
                        "assets/images/mobile_number_banner.svg")),
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
                Form(
                  key: mobileKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: kColorTextfieldBordered, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: kColorLightBlack, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
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
                          color: kColorLightBlack, fontSize: 16.sp),
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 20, top: 8, right: 10),
                      hintText: "Mobile Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Mobile Number";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    if (mobileKey.currentState!.validate()) {
                      context.read<LogInWithNumberBloc>().add(LoginRequest(
                          number: numberController.text, context: context));
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
                      "Continue",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: kColorWhite),
                    )),
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<LogInWithNumberBloc, LogInWithNumberState>(
              listener: (context, state) {
            if (state is LoginSuccess) {
              AutoRouter.of(context).push(OtpPageRoute(
                  mobile: numberController.text,
                  verificationId: state.verificationId));
              numberController.clear();
            }
            if (state is LoginFailed) {
              showSnackBarWidget(context, state.response, kColorPrimary);
            }
          }, builder: (context, state) {
            if (state is LoginLoading) {
              log("Loading");
              return const LoaderWidget();
            }
            return const SizedBox();
          })
        ],
      ),
    );
  }
}
