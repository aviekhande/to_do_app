import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/bloc/bottom_nav_bloc.dart';
import 'package:to_do_app/core/common/widget/snackbar_widget.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/features/add_task_details/presentation/pages/add_task_dialog.dart';
import 'package:to_do_app/features/calender_details/presentation/pages/add_task_screen.dart';
import 'package:to_do_app/features/graph_screen/presentation/pages/graph_screen.dart';
import 'package:to_do_app/features/home_screen/presentation/pages/home_screen.dart';
import 'package:to_do_app/features/profile_screen/presentation/pages/profile_screen.dart';
import '../../../flutter_gen/gen_l10n/app_localizations.dart';
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
    context.read<BottomNavBloc>().add(ChangeTab(index: 0));
    log("init state");
    internetBloc = context.read<InternetBloc>();
    internetBloc.checkInternet();
    internetBloc.trackConnectivityChange();
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CalendarScreen(),
    AddTaskScreen(),
    GraphScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    selectedIndex = index;
    context.read<BottomNavBloc>().add(ChangeTab(index: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<InternetBloc, InternetStatus>(
        listener: (context, state) {
          if (state.status == ConnectivityStatus.disconnected) {
            showSnackBarWidget(
                context, "No internet connection", Colors.black45);
          }
        },
        builder: (context, state) {
          return state.status == ConnectivityStatus.connected
              ? BlocBuilder<BottomNavBloc, BottomNavState>(
                  builder: (context, state) {
                    return IndexedStack(
                      index: state is BottomNavIndex ? state.index : 0,
                      children: _widgetOptions,
                    );
                  },
                )
              : Center(
                  child: Text(
                    "No Internet",
                    style: GoogleFonts.poppins(),
                  ),
                );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          if (state is BottomNavIndex) {
            selectedIndex = state.index;
          }
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 214, 232, 215),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                    padding: EdgeInsets.all(4.h),
                    child: const Icon(Icons.home_filled)),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: Container(
                    padding: EdgeInsets.all(4.h),
                    child: const Icon(Icons.calendar_month)),
                label: AppLocalizations.of(context)!.cal,
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
                label: AppLocalizations.of(context)!.graph,
              ),
              BottomNavigationBarItem(
                icon: Container(
                    padding: EdgeInsets.all(4.h),
                    child: const Icon(Icons.person)),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
            showUnselectedLabels: true,
            unselectedLabelStyle:
                GoogleFonts.poppins(color: Colors.grey, fontSize: 12.0),
            currentIndex: selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 98, 97, 97),
            unselectedItemColor: Colors.grey,
            unselectedIconTheme: const IconThemeData(size: 24.0),
            onTap: _onItemTapped,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                offset: const Offset(0, 7),
                blurRadius: 8)
          ]),
          child: FloatingActionButton(
            backgroundColor: kColorPrimary,
            elevation: 0,
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return const AddTaskDialog();
              //   },
              // );
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
      ),
    );
  }
}
