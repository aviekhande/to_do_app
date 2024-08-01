import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/loader_widget.dart';
import 'package:to_do_app/core/common/widget/snackbar_widget.dart';
import 'package:to_do_app/features/auth/presentation/bloc/forgotpassbloc/forgotpass_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> passKey1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45.h,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    AutoRouter.of(context).popForced();
                  },
                  child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kColorWhite,
                      ),
                      child: SvgPicture.asset("assets/icons/back_ic.svg")),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: GoogleFonts.poppins(
                        fontSize: 28.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppLocalizations.of(context)!.noWorries,
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  AppLocalizations.of(context)!.email,
                  style: GoogleFonts.poppins(fontSize: 16.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Form(
                  key: passKey1,
                  child: TextFormField(
                    style: GoogleFonts.poppins(color: Colors.black),
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kColorTextfieldBordered, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kColorLightBlack, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusColor: kColorPrimary,
                        fillColor: Colors.white,
                        hintText: AppLocalizations.of(context)!.enterYourEmail,
                        hintStyle: GoogleFonts.poppins(
                            color: kColorLightBlack, fontSize: 16.sp)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                ),
                // SizedBox(
                //   height: 380.h,
                // ),
                const Spacer(),
                BlocListener<ForgotPassBloc, ForgotPassState>(
                  listener: (context, state) {
                    if (state is ForgotPassSuccess) {
                      showSnackBarWidget(context, "Code send on Email");
                    }
                    if (state is ForgotPassFailed) {
                      showSnackBarWidget(context, "Something went wrong");
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (passKey1.currentState!.validate()) {
                        log("In Validate");
                        context
                            .read<ForgotPassBloc>()
                            .add(ForgotPassEvent(email: emailController.text));
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
                        AppLocalizations.of(context)!.sendResetInst,
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: kColorWhite),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
          BlocBuilder<ForgotPassBloc, ForgotPassState>(
              builder: (context, state) {
            if (state is ForgotPassLoading) {
              return const LoaderWidget();
            }
            return const SizedBox();
          })
        ],
      ),
    );
  }
}
