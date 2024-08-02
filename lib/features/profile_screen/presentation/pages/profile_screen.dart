import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/features/profile_screen/presentation/bloc/bloc/profile_bloc.dart';
import '../../../../core/common/widget/loader_widget.dart';
import '../../../../core/theme/colors.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';

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
    context.read<ProfileBloc>().add(ProfileFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Theme.of(context).colorScheme.surface,
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  AppLocalizations.of(context)!.profile,
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
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            offset: const Offset(0, 3),
                            blurRadius: 10)
                      ]),
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileFetch) {
                        // log("${state.docSnap['email']}");
                        email = state.docSnap['email'];
                        name = state.docSnap['name'];
                        imageUrl = state.docSnap['image'];
                      }
                      return Row(
                        children: [
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
                      color: Theme.of(context).colorScheme.surface ==
                              Colors.grey.shade700
                          ? Theme.of(context).colorScheme.surface
                          : const Color.fromARGB(255, 238, 245, 238),
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
                                  Text(AppLocalizations.of(context)!.myAcc,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp)),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .makeChangesToYourAcc,
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
                                Text(AppLocalizations.of(context)!.changePass,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp)),
                                Text(
                                    AppLocalizations.of(context)!
                                        .manageYourPass,
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
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
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
