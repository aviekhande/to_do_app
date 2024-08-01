import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:loader_overlay/loader_overlay.dart';
import 'package:to_do_app/core/common/widget/loader_widget.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/features/auth/presentation/bloc/bloc/signup_event.dart';
import 'package:to_do_app/features/auth/presentation/bloc/bloc/signup_state.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginbloc.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginevent.dart';
import '../../../../core/common/widget/snackbar_widget.dart';
import '../../../../core/common/widget/upload_photo.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/bloc/signup_bloc.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

String? imageUrl;

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> checkkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool unShowPass1 = true;
  bool unShowPass = true;
  String uploadImage = "";
  @override
  void initState() {
    super.initState();
    imageUrl = "";
  }

  Icon toggleIcon() {
    return Icon(
        unShowPass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  Icon toggleIcon1() {
    return Icon(
        unShowPass1 ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    confirmPasswordController.clear();
  }

  // void SignUpUser(context) async {
  //   // set is loading to true.

  //   String res = await AuthMethod().SignUpUser(
  //       email: emailController.text,
  //       password: passwordController.text,
  //       name: firstNameController.text,
  //       lastName: lastNameController.text,
  //       image: "$imageUrl");
  //   if (res == "success") {
  //     //navigate to the next screen
  //     AutoRouter.of(context).push(const HomeScreenRoute());
  //     clearController();
  //     imageUrl = "";
  //     showSnackBar(context, res);
  //   } else {
  //     // show error
  //     showSnackBar(context, "Account not crate");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   title: GestureDetector(
      //     onTap: () {
      //       AutoRouter.of(context).popForced();
      //     },
      //     child: Container(
      //         decoration: const BoxDecoration(
      //           shape: BoxShape.circle,
      //           // color: kColorWhite,
      //         ),
      //         child: SvgPicture.asset("assets/icons/back_ic.svg")),
      //   ),
      // ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(right: 15.w, left: 15.w),
            child: Form(
              key: checkkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context).popForced();
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          // color: kColorWhite,
                        ),
                        child: SvgPicture.asset("assets/icons/back_ic.svg")),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                      child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                        fontSize: 28.sp, fontWeight: FontWeight.w800),
                  )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            if (state is ProfileSelect) {
                              uploadImage = state.image;
                            }
                            return Container(
                              height: 85.h,
                              width: 85.w,
                              child: ClipOval(
                                  // borderRadius: BorderRadius.circular(
                                  //     100.0), // Adjust the radius as needed
                                  child: uploadImage.isNotEmpty
                                      ? Image.file(
                                          File(uploadImage),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/profile_image.png",
                                          fit: BoxFit.cover,
                                        )
                                  // : Image.network(
                                  //     imageUrl!,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 3.h,
                          left: 50.w,
                          child: GestureDetector(
                            onTap: () {
                              showOptionBottomSheet(context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kColorWhite,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 203, 202, 202),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "First Name",
                              style: GoogleFonts.poppins(fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              // width: 150.w,
                              child: TextFormField(
                                // key: checkkey,
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kColorTextfieldBordered,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: kColorWhite,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kColorLightBlack, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintStyle: GoogleFonts.poppins(
                                      color: kColorLightBlack, fontSize: 16.sp),
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, bottom: 20, top: 8, right: 10),
                                  hintText: "Jhon",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Name",
                              style: GoogleFonts.poppins(fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              // width: 150.w,
                              child: TextFormField(
                                // key: checkkey,
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kColorTextfieldBordered,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: kColorWhite,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: kColorLightBlack, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintStyle: GoogleFonts.poppins(
                                      color: kColorLightBlack, fontSize: 16.sp),
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, bottom: 20, top: 8, right: 10),
                                  hintText: "Doe",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Last Name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                    // key: checkkey,
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
                          borderSide: const BorderSide(
                              color: kColorLightBlack, width: 1.0),
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
                    height: 10.h,
                  ),
                  Text(
                    "Password",
                    style: GoogleFonts.poppins(fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    // key: checkkey,
                    obscureText: unShowPass1,
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
                        borderSide: const BorderSide(
                            color: kColorLightBlack, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              unShowPass1 = !unShowPass1;
                            });
                            toggleIcon1();
                          },
                          child: toggleIcon1()),
                      hintStyle: GoogleFonts.poppins(
                          color: kColorLightBlack, fontSize: 16.sp),
                      // contentPadding: const EdgeInsets.only(
                      //     left: 15, bottom: 20, top: 8, right: 10),
                      hintText: "*********",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Password";
                      }
                      if (value.length < 6) {
                        return "Password Must greater than 6";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Confirm Password",
                    style: GoogleFonts.poppins(fontSize: 16.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    // key: checkkey,
                    obscureText: unShowPass,
                    obscuringCharacter: "*",
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: kColorTextfieldBordered, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: kColorWhite,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: kColorLightBlack, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              unShowPass = !unShowPass;
                            });
                            toggleIcon();
                          },
                          child: toggleIcon()),
                      hintStyle: GoogleFonts.poppins(
                          color: kColorLightBlack, fontSize: 16.sp),
                      // contentPadding: const EdgeInsets.only(
                      //     left: 15, bottom: 10, top: 25, right: 10),
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
                    height: 45.h,
                  ),
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        AutoRouter.of(context).replaceAll(
                            [const CommonbottomnavigationbarRoute()]);
                        clearController();
                      } else if (state is SignUpFailed) {
                        showSnackBarWidget(context, state.response);
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () async {
                          log("InCreate");

                          FocusScope.of(context).unfocus();
                          if (checkkey.currentState!.validate()) {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              if (state is ProfileSelect) {
                                imageUrl = state.image;
                              }
                              context.read<SignUpBloc>().add(SignUpRequest(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: firstNameController.text,
                                  lastName: lastNameController.text,
                                  image: imageUrl!));
                              context.read<LoginBloc>().add(LoginInitial());
                            } else {
                              showSnackBarWidget(context,
                                  "Confirm password and password not match");
                            }
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
                            "Create Account",
                            style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: kColorWhite),
                          )),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
          if (state is SignUpLoading) {
            return const LoaderWidget();
          }
          return const SizedBox();
        })
      ]),
    );
  }

  // Future<void> showOptionBottomSheet() async {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: 120.h,
  //         width: 411.42857142857144.w,
  //         child: Padding(
  //           padding: EdgeInsets.all(20.w),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               GestureDetector(
  //                 onTap: () {
  //                   uploadPhoto("cam");
  //                 },
  //                 child: Row(
  //                   children: [
  //                     const Icon(
  //                       Icons.camera,
  //                       color: kColorPrimary,
  //                     ),
  //                     SizedBox(
  //                       width: 10.w,
  //                     ),
  //                     Text(
  //                       "Camera",
  //                       style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 25.w),
  //               GestureDetector(
  //                 onTap: () {
  //                   uploadPhoto("gal");
  //                 },
  //                 child: Row(
  //                   children: [
  //                     const Icon(
  //                       Icons.photo,
  //                       color: kColorPrimary,
  //                     ),
  //                     SizedBox(
  //                       width: 10.w,
  //                     ),
  //                     Text(
  //                       "Gallery",
  //                       style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> uploadPhoto(String option) async {
  //   final ImagePicker picker = ImagePicker();
  //   String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
  //   XFile? file = await picker.pickImage(
  //       source: option == "cam" ? ImageSource.camera : ImageSource.gallery);
  //   AutoRouter.of(context).popForced();
  //   if (file == null) return;

  //   Reference referenceToUpload =
  //       FirebaseStorage.instance.ref().child('images').child(uniqueFileName);

  //   try {
  //     // context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));
  //     context.loaderOverlay.show();
  //     await referenceToUpload.putFile(File(file.path));
  //     imageUrl = await referenceToUpload.getDownloadURL();
  //     // context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));

  //     context.loaderOverlay.hide();
  //     setState(() {});
  //     log(imageUrl!);
  //   } catch (e) {
  //     log("IN Catch");
  //     context.loaderOverlay.hide();
  //     rethrow;
  //   }
  // }
}
