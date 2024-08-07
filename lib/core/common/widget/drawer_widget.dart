import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/bloc/bottom_nav_bloc.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../features/profile_screen/presentation/bloc/bloc/profile_bloc.dart';

class CommonDrawer extends StatefulWidget {
  final String page;
  const CommonDrawer({super.key, required this.page});

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
    context.read<ProfileBloc>().add(ProfileFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = Theme.of(context).colorScheme.surface == Colors.grey.shade700;
    return Drawer(
      elevation: 100,
      backgroundColor: kColorPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
      ),
      child: Column(
        children: [
          Container(
            color: kColorPrimary,
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileFetch) {
                    name = state.docSnap['name'];
                    imageUrl = state.docSnap['image'];
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        "Welcome $name ",
                        style: GoogleFonts.poppins(
                            color: kColorWhite,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // Text(
                      //   "$email ",
                      //   style: GoogleFonts.poppins(
                      //       color: kColorWhite, fontSize: 16.sp),
                      // )
                    ],
                  );
                },
              ),
            ),
          ),
          const Divider(
            color: kColorWhite,
          ),
          SizedBox(
            height: 30.h,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<BottomNavBloc>().add(ChangeTab(index: 0));
                  AutoRouter.of(context).popForced();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                  decoration: BoxDecoration(
                      color:
                          widget.page == "Home" ? Colors.white : kColorPrimary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: Row(
                    children: [
                      Icon(Icons.home,
                          color: widget.page == "Home"
                              ? kColorPrimary
                              : kColorWhite),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.home,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: widget.page == "Home"
                                ? kColorPrimary
                                : kColorWhite),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  context.read<BottomNavBloc>().add(ChangeTab(index: 1));
                  AutoRouter.of(context).popForced();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                  decoration: BoxDecoration(
                      color: widget.page != "Cal" ? kColorPrimary : kColorWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month,
                          color: widget.page == "Cal"
                              ? kColorPrimary
                              : kColorWhite),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.cal,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: widget.page == "Cal"
                                ? kColorPrimary
                                : kColorWhite),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  context.read<BottomNavBloc>().add(ChangeTab(index: 3));
                  AutoRouter.of(context).popForced();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                  decoration: BoxDecoration(
                      color:
                          widget.page != "Graph" ? kColorPrimary : kColorWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: Row(
                    children: [
                      Icon(Icons.timelapse_outlined,
                          color: widget.page == "Graph"
                              ? kColorPrimary
                              : kColorWhite),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.graph,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: widget.page == "Graph"
                                ? kColorPrimary
                                : kColorWhite),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  context.read<BottomNavBloc>().add(ChangeTab(index: 4));
                  AutoRouter.of(context).popForced();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                  decoration: BoxDecoration(
                      color:
                          widget.page != "Prof" ? kColorPrimary : kColorWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: Row(
                    children: [
                      Icon(Icons.person,
                          color: widget.page == "Prof"
                              ? kColorPrimary
                              : kColorWhite),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.profile,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: widget.page == "Prof"
                                ? kColorPrimary
                                : kColorWhite),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(const RecyclePageRoute());
                  AutoRouter.of(context).popForced();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                  decoration: BoxDecoration(
                      color: widget.page != "Rec" ? kColorPrimary : kColorWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever,
                          color: widget.page == "Rec"
                              ? kColorPrimary
                              : kColorWhite),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.recycle,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: widget.page == "Rec"
                                ? kColorPrimary
                                : kColorWhite),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(const SettingsPageRoute());
                  AutoRouter.of(context).popForced();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 30.w),
                  decoration: BoxDecoration(
                      color: widget.page != "Set" ? kColorPrimary : kColorWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: Row(
                    children: [
                      Icon(Icons.settings,
                          color: widget.page == "Set"
                              ? kColorPrimary
                              : kColorWhite),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(
                        AppLocalizations.of(context)!.set,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: widget.page == "Set"
                                ? kColorPrimary
                                : kColorWhite),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
