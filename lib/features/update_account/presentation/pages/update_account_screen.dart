import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/loader_widget.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../core/common/widget/upload_photo.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../../../auth/presentation/bloc/bloc/signup_bloc.dart';
import '../../../auth/presentation/bloc/bloc/signup_event.dart';
import '../../../auth/presentation/bloc/bloc/signup_state.dart';
import '../../../profile_screen/presentation/bloc/bloc/profile_bloc.dart';

@RoutePage()
class UpdateAccountScreen extends StatefulWidget {
  const UpdateAccountScreen({super.key});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  GlobalKey<FormState> checkkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool unShowPass1 = true;
  bool unShowPass = true;
  var uploadImage = "";
  Icon toggleIcon() {
    return Icon(
        unShowPass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  Icon toggleIcon1() {
    return Icon(
        unShowPass1 ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  String email = "Email";
  String name = "Name";
  String imageUrl = "";
  String imageUrl1 = "";
  String lastName = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h, right: 15.w, left: 15.w),
              child: Form(
                key: checkkey,
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileFetch) {
                      log("Form Profileloadin");
                      lastNameController.text = state.docSnap['lastName'];
                      firstNameController.text = state.docSnap['name'];
                      imageUrl = state.docSnap['image'];
                      imageUrl1 = imageUrl;
                      email = state.docSnap['email'];
                      log("Image:$imageUrl");
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfileFetch) {
                      lastNameController.text = state.docSnap['lastName'];
                      firstNameController.text = state.docSnap['name'];
                      imageUrl = state.docSnap['image'];
                      imageUrl1 = imageUrl;
                      email = state.docSnap['email'];
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            AutoRouter.of(context).back();
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorWhite,
                              ),
                              child:
                                  SvgPicture.asset("assets/icons/back_ic.svg")),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 85.h,
                                width: 85.w,
                                child: BlocBuilder<SignUpBloc, SignUpState>(
                                  builder: (context, state) {
                                    if (state is ProfileSelect) {
                                      uploadImage = state.image;
                                      imageUrl1 = "";
                                    }
                                    // log("imageUrl1:$imageUrl1 ");
                                    return ClipOval(
                                      child: imageUrl1.isEmpty
                                          ? uploadImage.isNotEmpty
                                              ? Image.file(
                                                  File(uploadImage),
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/images/profile_image.png",
                                                  fit: BoxFit.cover,
                                                )
                                          : Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                    );
                                  },
                                ),
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
                                              color: Color.fromARGB(
                                                  255, 203, 202, 202),
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
                                  Text(AppLocalizations.of(context)!.firstName),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      controller: firstNameController,
                                      decoration: InputDecoration(
                                        hintStyle: GoogleFonts.poppins(
                                            color: kColorLightBlack,
                                            fontSize: 16.sp),
                                        contentPadding: const EdgeInsets.only(
                                            left: 15,
                                            bottom: 20,
                                            top: 8,
                                            right: 10),
                                        hintText: "Jhon",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                              width: 20.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.lastName),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      controller: lastNameController,
                                      decoration: InputDecoration(
                                        hintStyle: GoogleFonts.poppins(
                                            color: kColorLightBlack,
                                            fontSize: 16.sp),
                                        contentPadding: const EdgeInsets.only(
                                            left: 15,
                                            bottom: 20,
                                            top: 8,
                                            right: 10),
                                        hintText: "Doe",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                          height: 300.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (checkkey.currentState!.validate()) {
                              log("upload:${uploadImage.isNotEmpty}");
                              log("uploadImage:$uploadImage");
                              uploadImage.isNotEmpty
                                  ? context.read<ProfileBloc>().add(
                                      UpdateRequest(
                                          email: email,
                                          image: uploadImage,
                                          lastName: lastNameController.text,
                                          name: firstNameController.text,
                                          isImage: false))
                                  : context.read<ProfileBloc>().add(
                                      UpdateRequest(
                                          email: email,
                                          image: imageUrl,
                                          lastName: lastNameController.text,
                                          name: firstNameController.text,
                                          isImage: true));
                            }
                            imageUrl1 = imageUrl;
                            uploadImage = "";
                            context
                                .read<SignUpBloc>()
                                .add(ProfileImageSuccessEvent());
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 50.w, right: 50.w, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: kColorPrimary,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!.updateAcc,
                              style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: kColorWhite),
                            )),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            log("$state");
            if (state is UpdateProfileLoading) {
              return const LoaderWidget();
            }
            return const SizedBox();
          })
        ],
      ),
    );
  }
}
