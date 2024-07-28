import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/core/common/widget/loader_widget.dart';
import 'package:to_do_app/core/common/widget/snackbar_widget.dart';
import 'package:to_do_app/features/update_account/presentation/bloc/updateprofile_bloc.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../core/common/widget/upload_photo.dart';
import '../../../auth/presentation/bloc/bloc/signup_bloc.dart';
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
  String lastName = "";
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileEvent());
  }

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h, right: 15.w, left: 15.w),
              child: Form(
                key: checkkey,
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      log("${state.docSnap['email']}");
                      lastNameController.text = state.docSnap['lastName'];
                      firstNameController.text = state.docSnap['name'];
                      imageUrl = state.docSnap['image'];
                      email = state.docSnap['email'];
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("First Name"),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  width: 150.w,
                                  child: TextFormField(
                                    // key: checkkey,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Last Name"),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  width: 150.w,
                                  child: TextFormField(
                                    // key: checkkey,
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
                          ],
                        ),
                        SizedBox(
                          height: 300.h,
                        ),
                        BlocListener<ProfileBloc, ProfileState>(
                          listener: (context, state) {
                            if (state is UpdateProfileSuccess) {
                              showSnackBarWidget(
                                  context, "Update SuccessFully");
                            }
                            if (state is UpdateProfileFailed) {
                              showSnackBarWidget(context, state.res);
                            }
                          },
                          child: GestureDetector(
                            onTap: () {
                              if (checkkey.currentState!.validate()) {
                                context.read<ProfileBloc>().add(
                                    UpdateRequest(
                                        email: email,
                                        image: uploadImage,
                                        lastName: lastNameController.text,
                                        name: firstNameController.text));
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
                                "Update Account",
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kColorWhite),
                              )),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
            if (state is UpdateProfileLoading) {
              return const LoaderWidget();
            }
            return const SizedBox();
          })
        ],
      ),
    );
  }

  // Future<void> showOptionBottomSheet() async {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: 100.h,
  //         width: 360.w,
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
  //   // String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
  //   XFile? file = await picker.pickImage(
  //       source: option == "cam" ? ImageSource.camera : ImageSource.gallery);
  //   AutoRouter.of(context).popForced();
  // if (file == null) return;

  // Reference referenceToUpload =
  //     FirebaseStorage.instance.ref().child('images').child(uniqueFileName);

  // try {
  //   context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));
  //   context.loaderOverlay.show();
  //   await referenceToUpload.putFile(File(file.path));
  //   imageUrl = await referenceToUpload.getDownloadURL();
  //   context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));

  //   context.loaderOverlay.hide();
  //   log(imageUrl);
  // } catch (e) {
  //   log("IN Catch");
  //   rethrow;
  // }
  // }
}
