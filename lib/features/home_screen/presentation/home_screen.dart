import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/bottomnav_widget.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/core/theme/routes/app_router.dart';

import '../../../core/common/widget/drawer_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List todoList = [1];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.sunny,
            size: 18.h,
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: todoList.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 195, 194, 194),
                              blurRadius: 5,
                              offset: Offset(0, 3))
                        ],
                        color: const Color.fromARGB(255, 237, 236, 236),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        const Icon(Icons.check_box_outline_blank),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Task",
                              style: GoogleFonts.poppins(),
                            ),
                            Text(
                              "Date /time",
                              style: GoogleFonts.poppins(),
                            )
                          ],
                        ),
                        const Spacer(),
                        Icon(Icons.delete)
                      ],
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                      height: 230.h,
                      child: SvgPicture.asset(
                        "assets/images/empty_img.svg",
                        height: 230.h,
                      )),
                  Text(
                    "What do you want to do today?",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Tap + to add your tasks",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 148, 170, 153),
              spreadRadius: 2,
              offset: Offset(0, 4),
              blurRadius: 10)
        ]),
        child: FloatingActionButton(
          backgroundColor: kColorPrimary,
          elevation: 0,
          onPressed: () {
            AutoRouter.of(context).push(const AddTaskScreenRoute());
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            color: kColorWhite,
          ),
        ),
      ),
      bottomNavigationBar: const Commonbottomnavigationbar(),
      drawer: const CommonDrawer(),
    );
  }
}
