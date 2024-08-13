import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/loader_widget.dart';
import '../../../../core/common/widget/appbar_widget.dart';
import '../../../../core/common/widget/snackbar_widget.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/login_number_bloc/log_in_with_number_bloc.dart';

@RoutePage()
class OtpPage extends StatefulWidget {
  final String mobile;
  final String verificationId;
  const OtpPage(
      {super.key, required this.mobile, required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController number1Controller = TextEditingController();
  TextEditingController number2Controller = TextEditingController();
  TextEditingController number3Controller = TextEditingController();
  TextEditingController number4Controller = TextEditingController();
  TextEditingController number5Controller = TextEditingController();
  TextEditingController number6Controller = TextEditingController();

  TextEditingController getController(int ind) {
    if (ind == 0) {
      return number1Controller;
    } else if (ind == 1) {
      return number2Controller;
    } else if (ind == 2) {
      return number3Controller;
    } else if (ind == 3) {
      return number4Controller;
    } else if (ind == 4) {
      return number5Controller;
    } else {
      return number6Controller;
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
      body: BlocListener<LogInWithNumberBloc, LogInWithNumberState>(
        listener: (context, state) {
          if (state is LoginSuccess1) {
            AutoRouter.of(context).push(const HomeScreenRoute());
          }
          if (state is LoginFailed) {
            showSnackBarWidget(context, state.response, kColorPrimary);
          }
        },
        child: Stack(
          children: [
            Padding(
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
                    children: List.generate(6, (index) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        width: 40.w,
                        height: 40.h,
                        child: TextFormField(
                          maxLength: 1,
                          controller: getController(index),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
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
                            counterText: "",
                            hintStyle: GoogleFonts.poppins(
                                color: kColorLightBlack, fontSize: 16.sp),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.h),
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
                    onTap: () {
                      context.read<LogInWithNumberBloc>().add(NumberVerify(
                          verificationId: widget.verificationId,
                          otp: number1Controller.text +
                              number2Controller.text +
                              number3Controller.text +
                              number4Controller.text +
                              number5Controller.text +
                              number6Controller.text,
                          context: context));
                    },
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
                          context.read<LogInWithNumberBloc>().add(LoginRequest(
                              number: widget.mobile, context: context));
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
            BlocBuilder(builder: (context, state) {
              if (state is LoginLoading1) {
                return const LoaderWidget();
              }
              return const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
