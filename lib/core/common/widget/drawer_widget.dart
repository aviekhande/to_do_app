import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/theme/colors.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  bool isDarkTheme = false;
  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    setState(() {});
  }

  String selectedValue = "English";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: kColorPrimary,
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50.h,
                  ),
                  Image.asset(
                    "assets/images/profile_image.png",
                    height: 40.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Name ",
                    style: GoogleFonts.poppins(
                        color: kColorWhite, fontSize: 14.sp),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Email",
                    style: GoogleFonts.poppins(
                        color: kColorWhite, fontSize: 14.sp),
                  )
                ],
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
                      fontWeight: FontWeight.w600, fontSize: 14.sp),
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
                        changeTheme();
                      },
                      child: Container(
                        height: 23.h,
                        width: 44.w,
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
                Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
