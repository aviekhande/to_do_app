import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/theme/colors.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
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
                  const Text(
                    "Name ",
                    style: TextStyle(color: kColorWhite),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(color: kColorWhite),
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
                const Text(
                  "Translate",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const Row(
                  children: [Icon(Icons.g_translate_sharp)],
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
                    Container(
                      height: 20.h,
                      width: 50.w,
                      child: Row(
                        children: [
                          Container(
                            height: 10,
                            decoration: const BoxDecoration(
                                color: kColorLightBlack,
                                shape: BoxShape.circle),
                          )
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.dark_mode,
                      // color: Colors.amber,
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
                    const Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.w600),
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
