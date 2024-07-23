import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/core/common/widget/bottomnav_widget.dart';
import 'package:to_do_app/core/theme/colors.dart';

import '../../../core/common/widget/drawer_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List todoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: GestureDetector(
          //   child: const Icon(Icons.menu),
          // ),
          ),
      body: todoList.isNotEmpty
          ? const Column(
              children: [],
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
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Tap + to add your tasks",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
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
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: FloatingActionButton(
          backgroundColor: kColorPrimary,
          elevation: 0,
          onPressed: () {},
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
