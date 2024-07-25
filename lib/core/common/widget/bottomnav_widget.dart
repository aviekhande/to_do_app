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
//   @override
//   void initState() {
//     log("init state");
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
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
//     //  BottomNavigationBar(
//     //   backgroundColor: Colors.green,
//     //   items: const <BottomNavigationBarItem>[
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.home_filled),
//     //       label: 'Home',
//     //     ),
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.calendar_month),
//     //       label: 'calender',
//     //     ),
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.data_saver_off_rounded),
//     //       label: 'Posts',
//     //     ),
//     //     BottomNavigationBarItem(
//     //       icon: Icon(Icons.person),
//     //       label: 'Profile',
//     //     ),
//     //   ],
//     //   showUnselectedLabels: true,
//     //   unselectedLabelStyle: const GoogleFonts.poppins(color: Colors.grey, fontSize: 12.0),
//     //   currentIndex: selectedIndex,
//     //   selectedItemColor: Colors.grey,
//     //   unselectedItemColor: Colors.grey,
//     //   selectedIconTheme:
//     //       const IconThemeData(size: 30.0), // Increased size for selected icon
//     //   unselectedIconTheme:
//     //       const IconThemeData(size: 24.0), // Default size for unselected icons
//     //   onTap: _onItemTapped,
//     // );
//   }
// }
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/core/theme/routes/app_router.dart';

class Commonbottomnavigationbar extends StatefulWidget {
  const Commonbottomnavigationbar({super.key});

  @override
  State<Commonbottomnavigationbar> createState() =>
      _CommonbottomnavigationbarState();
}

int selectedIndex = 0;

class _CommonbottomnavigationbarState extends State<Commonbottomnavigationbar> {
  void _onItemTapped(int index) {
    // if (selectedIndex == index) {
    //   return;
    // }
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        AutoRouter.of(context).push(const HomeScreenRoute());
        break;
      case 1:
        AutoRouter.of(context).push(const AddTaskScreenRoute());
        break;
      case 2:
        // Add navigation for third item if needed
        break;
      case 3:
        AutoRouter.of(context).push(const ProfileScreenRoute());
        break;
    }
  }

  @override
  void initState() {
    log("init state");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      color: const Color.fromARGB(255, 214, 232, 215),
      child: Padding(
        padding: const EdgeInsets.only(right: 25.0, left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              icon: Icons.home,
              index: 0,
            ),
            _buildNavItem(
              icon: Icons.calendar_month_outlined,
              index: 1,
            ),
            SizedBox(width: 20.w), // Add space between items
            _buildNavItem(
              icon: Icons.timelapse_outlined,
              index: 2,
            ),
            _buildNavItem(
              icon: Icons.person,
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: kColorLightBlack,
            // color: selectedIndex == index ? kColorLightBlack : Colors.black,
          ),
        ],
      ),
    );
  }
}
