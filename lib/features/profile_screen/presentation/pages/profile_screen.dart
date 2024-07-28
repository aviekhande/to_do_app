import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/features/profile_screen/presentation/bloc/bloc/profile_bloc.dart';
import '../../../../core/theme/colors.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

DocumentSnapshot? docSnap;

class _ProfileScreenState extends State<ProfileScreen> {
  String email = "Email";
  String name = "Name";
  String imageUrl = "";
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: GestureDetector(
      //     onTap: () {
      //       // AutoRouter.of(context).popForced();
      //     },
      //     child: Container(
      //         decoration: const BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: kColorWhite,
      //         ),
      //         child: SvgPicture.asset("assets/icons/back_ic.svg")),
      //   ),
      
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.h,
            ),
            Text(
              "Profile",
              style: GoogleFonts.poppins(
                  fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.all(15.h),
              decoration: BoxDecoration(
                  color: kColorPrimary,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ]),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    log("${state.docSnap['email']}");
                    email = state.docSnap['email'];
                    name = state.docSnap['name'];
                    imageUrl = state.docSnap['image'];
                  }
                  return Row(
                    children: [
                      // SizedBox(
                      //   width: 15.w,
                      // ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        height: 85.h,
                        width: 85.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kColorWhite,
                        ),
                        child: SizedBox(
                          height: 70.h,
                          width: 70.w,
                          child: ClipOval(
                            child: imageUrl.isEmpty
                                ? Image.asset(
                                    "assets/images/profile_image.png",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
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
                              email,
                              style: GoogleFonts.poppins(
                                  color: kColorWhite, fontSize: 16.sp),
                            ),
                            Text(
                              name,
                              style: GoogleFonts.poppins(
                                  color: kColorWhite, fontSize: 16.sp),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 245, 238),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context)
                          .push(const UpdateAccountScreenRoute());
                    },
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("My Account",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp)),
                              Text("Make changes to your account",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp))
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Divider(
                    height: BorderSide.strokeAlignCenter,
                    color: Color.fromARGB(255, 235, 234, 234),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      AutoRouter.of(context)
                          .push(const ForgotPasswordScreenRoute());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Change Password",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp)),
                            Text("Manage your password",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp))
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16.sp,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const Commonbottomnavigationbar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: const CommonFloatingActionButton(),
    );
  }
}
