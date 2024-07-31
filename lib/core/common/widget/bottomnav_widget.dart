import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/features/add_task_details/presentation/pages/add_task_dialog.dart';
import 'package:to_do_app/features/calender_details/presentation/pages/add_task_screen.dart';
import 'package:to_do_app/features/graph_screen/presentation/pages/blank_screen.dart';
import 'package:to_do_app/features/home_screen/presentation/pages/home_screen.dart';
import 'package:to_do_app/features/profile_screen/presentation/pages/profile_screen.dart';

import '../../routes/app_router.dart';
import '../../services/network/bloc/internet_bloc/internet_bloc.dart';

@RoutePage()
class Commonbottomnavigationbar extends StatefulWidget {
  const Commonbottomnavigationbar({super.key});

  @override
  State<Commonbottomnavigationbar> createState() =>
      _CommonbottomnavigationbarState();
}

class _CommonbottomnavigationbarState extends State<Commonbottomnavigationbar> {
  int selectedIndex = 0;
  late InternetBloc internetBloc;

  @override
  void initState() {
    log("init state");
    internetBloc = context.read<InternetBloc>();
    internetBloc.checkInternet();
    internetBloc.trackConnectivityChange();
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddTaskScreen(),
    AddTaskScreen(),
    GraphScreen(),
    ProfileScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<InternetBloc, InternetStatus>(
        listener: (context, state) {
          if (state.status == ConnectivityStatus.disconnected) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              "No internet connection",
              style: GoogleFonts.poppins(),
            )));
          }
        },
        builder: (context, state) {
          return state.status == ConnectivityStatus.connected
              ? IndexedStack(
                  index: selectedIndex,
                  children: _widgetOptions,
                )
              : Center(
                  child: Text(
                    "No Internet",
                    style: GoogleFonts.poppins(),
                  ),
                );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            label: 'Graph',
          ),
          BottomNavigationBarItem(
            icon: Container(
                padding: EdgeInsets.all(4.h), child: const Icon(Icons.person)),
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
