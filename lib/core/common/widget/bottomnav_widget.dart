import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/features/add_task_details/presentation/pages/add_task_dialog.dart';
import 'package:to_do_app/features/calender_details/presentation/pages/add_task_screen.dart';
import 'package:to_do_app/features/blank_screen/presentation/blank_screen.dart';
import 'package:to_do_app/features/home_screen/presentation/pages/home_screen.dart';
import 'package:to_do_app/features/profile_screen/presentation/pages/profile_screen.dart';

import '../../routes/app_router.dart';

@RoutePage()
class Commonbottomnavigationbar extends StatefulWidget {
  const Commonbottomnavigationbar({super.key});

  @override
  State<Commonbottomnavigationbar> createState() =>
      _CommonbottomnavigationbarState();
}

class _CommonbottomnavigationbarState extends State<Commonbottomnavigationbar> {
  int selectedIndex = 0;
  @override
  void initState() {
    log("init state");
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddTaskScreen(),
    AddTaskScreen(),
    BlankScreen(),
    ProfileScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
// Container(
//       height: 50.h,
//       color: Color.fromARGB(255, 214, 232, 215),
//       child: Padding(
//         padding: const EdgeInsets.only(right: 25.0, left: 25),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 if (selectedIndex != 0) {
//                   AutoRouter.of(context).push(const HomeScreenRoute());
//                   selectedIndex = 0;
//                 }
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.home,
//                     color: selectedIndex != 0 ? Colors.black : kColorLightBlack,
//                   ),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 log("$selectedIndex");
//                 if (selectedIndex != 1) {
//                   AutoRouter.of(context).push(const AddTaskScreenRoute());
//                   selectedIndex = 1;
//                 }
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.calendar_month_outlined),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 10.w,
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.timelapse_outlined),
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 if (selectedIndex != 3) {
//                   AutoRouter.of(context).push(const ProfileScreenRoute());
//                   selectedIndex = 3;
//                 }
//               },
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.person),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
        Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 214, 232, 215),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.all(4.h),
                  child: const Icon(Icons.home_filled)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.all(4.h),
                  child: const Icon(Icons.calendar_month)),
              label: 'calender',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(4.h),
                child: const Icon(
                  Icons.do_not_touch,
                  color: Color.fromARGB(255, 214, 232, 215),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.all(4.h),
                  child: const Icon(Icons.timelapse_outlined)),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  padding: EdgeInsets.all(4.h),
                  child: const Icon(Icons.person)),
              label: 'Profile',
            ),
          ],
          showUnselectedLabels: true,
          unselectedLabelStyle:
              GoogleFonts.poppins(color: Colors.grey, fontSize: 12.0),
          currentIndex: selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 98, 97, 97),
          unselectedItemColor: Colors.grey,
          // selectedIconTheme:
          //     const IconThemeData(size: 24.0),
          unselectedIconTheme: const IconThemeData(size: 24.0),
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 2,
              offset: const Offset(0, 4),
              blurRadius: 10)
        ]),
        child: FloatingActionButton(
          backgroundColor: kColorPrimary,
          elevation: 0,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddTaskDialog();
              },
            );
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
    );
  }
}
// import 'dart:developer';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:to_do_app/core/theme/colors.dart';
// import 'package:to_do_app/core/theme/routes/app_router.dart';

// class Commonbottomnavigationbar extends StatefulWidget {
//   const Commonbottomnavigationbar({super.key});

//   @override
//   State<Commonbottomnavigationbar> createState() =>
//       _CommonbottomnavigationbarState();
// }

// int selectedIndex = 0;

// class _CommonbottomnavigationbarState extends State<Commonbottomnavigationbar> {
//   void _onItemTapped(int index) {
//     // if (selectedIndex == index) {
//     //   return;
//     // }
//     setState(() {
//       selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         AutoRouter.of(context).push(const HomeScreenRoute());
//         break;
//       case 1:
//         AutoRouter.of(context).push(const AddTaskScreenRoute());
//         break;
//       case 2:
//         // Add navigation for third item if needed
//         break;
//       case 3:
//         AutoRouter.of(context).push(const ProfileScreenRoute());
//         break;
//     }
//   }

//   @override
//   void initState() {
//     log("init state");
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50.h,
//       color: const Color.fromARGB(255, 214, 232, 215),
//       child: Padding(
//         padding: const EdgeInsets.only(right: 25.0, left: 25),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildNavItem(
//               icon: Icons.home,
//               index: 0,
//             ),
//             _buildNavItem(
//               icon: Icons.calendar_month_outlined,
//               index: 1,
//             ),
//             SizedBox(width: 20.w), // Add space between items
//             _buildNavItem(
//               icon: Icons.timelapse_outlined,
//               index: 2,
//             ),
//             _buildNavItem(
//               icon: Icons.person,
//               index: 3,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({required IconData icon, required int index}) {
//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: kColorLightBlack,
//             // color: selectedIndex == index ? kColorLightBlack : Colors.black,
//           ),
//         ],
//       ),
//     );
//   }
// }
