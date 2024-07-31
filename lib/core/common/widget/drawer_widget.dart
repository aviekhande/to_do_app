import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/logout_alert_dialog_box.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginbloc.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginstate.dart';
import '../../../features/profile_screen/presentation/bloc/bloc/profile_bloc.dart';
import '../../theme/app_theme.dart';
import '../../theme/bloc/theme_bloc_bloc.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

bool isDarkTheme = false;

class _CommonDrawerState extends State<CommonDrawer> {
  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    setState(() {});
  }

  String selectedValue = "English";

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
    isDarkTheme = Theme.of(context).colorScheme.surface == Colors.grey.shade700;
    return Drawer(
      child: Column(
        children: [
          Container(
            color: kColorPrimary,
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileFetch) {
                    log("${state.docSnap['email']}");
                    email = state.docSnap['email'];
                    name = state.docSnap['name'];
                    imageUrl = state.docSnap['image'];
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.h,
                      ),
                      SizedBox(
                        height: 80.h,
                        width: 80.w,
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "$name ",
                        style: GoogleFonts.poppins(
                            color: kColorWhite, fontSize: 16.sp),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$email ",
                        style: GoogleFonts.poppins(
                            color: kColorWhite, fontSize: 16.sp),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.w,
                ),
                Text(
                  "Translate",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    const Icon(Icons.g_translate_sharp),
                    SizedBox(
                      width: 10.w,
                    ),
                    DropdownButton(
                        isDense: true,
                        autofocus: true,
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                              value: "English",
                              child: Text(
                                "English",
                                style: GoogleFonts.poppins(fontSize: 12.sp),
                              )),
                          DropdownMenuItem(
                              value: "Hindi",
                              child: Text("Hindi",
                                  style: GoogleFonts.poppins(fontSize: 12.sp))),
                        ])
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.sunny,
                      color: Colors.amber,
                    ),
                    GestureDetector(
                      onTap: () {
                        isDarkTheme
                            ? context
                                .read<ThemeBlocBloc>()
                                .add(ThemeBlocEvent(themeData: lightMode))
                            : context
                                .read<ThemeBlocBloc>()
                                .add(ThemeBlocEvent(themeData: darkMode));
                        changeTheme();
                        log("changeTheme");
                      },
                      child: Container(
                        height: 23.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                            // color: const Color.fromARGB(255, 205, 203, 203),
                            color: isDarkTheme
                                ? const Color.fromARGB(255, 54, 14, 135)
                                : const Color.fromARGB(255, 205, 203, 203),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: kColorLightBlack, width: 2)),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(4.h),
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                  // color: kColorLightBlack,
                                  color: isDarkTheme
                                      ? const Color.fromARGB(255, 54, 14, 135)
                                      : kColorLightBlack,
                                  shape: BoxShape.circle),
                            ),
                            Container(
                              margin: EdgeInsets.all(1.h),
                              width: 17.w,
                              height: 17.h,
                              decoration: BoxDecoration(
                                  color: isDarkTheme
                                      ? kColorWhite
                                      : const Color.fromARGB(
                                          255, 205, 203, 203),
                                  shape: BoxShape.circle),
                            )
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.dark_mode,
                      color: isDarkTheme
                          ? const Color.fromARGB(255, 54, 14, 135)
                          : kColorLightBlack,
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                  if (state is Logout) {
                    log("IN LogoutState");
                    AutoRouter.of(context)
                        .replaceAll([const OptionScreenRoute()]);
                  }
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => const LogoutAlertDialogBox());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Logout",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        )
                      ],
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
