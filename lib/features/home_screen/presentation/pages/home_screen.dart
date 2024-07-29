import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/features/home_screen/presentation/bloc/task_bloc.dart';
import 'package:to_do_app/features/home_screen/presentation/widgets/task_container.dart';
import '../../../../core/common/widget/drawer_widget.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/bloc/theme_bloc_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddTasksBloc>().add(TaskAdd()); // Initial fetch of tasks
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Theme.of(context).colorScheme.surface == Colors.grey.shade700
                  ? context
                      .read<ThemeBlocBloc>()
                      .add(ThemeBlocEvent(themeData: lightMode))
                  : context
                      .read<ThemeBlocBloc>()
                      .add(ThemeBlocEvent(themeData: darkMode));
            },
            child: Icon(
              Icons.sunny,
              size: 18.h,
              color:
                  Theme.of(context).colorScheme.surface == Colors.grey.shade700
                      ? Colors.black
                      : Colors.amber,
            ),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          children: [
            BlocBuilder<AddTasksBloc, AddTasksState>(
              builder: (context, state) {
                if (state is AddTaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AddTaskSuccess) {
                  log("${state.task.isEmpty}PPPPPPPPPPPPPP");
                  return state.task.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              SizedBox(height: 100.h),
                              SizedBox(
                                height: 230.h,
                                child: SvgPicture.asset(
                                  "assets/images/empty_img.svg",
                                  height: 230.h,
                                ),
                              ),
                              Text(
                                "What do you want to do today?",
                                style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                "Tap + to add your tasks",
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: state.task.length,
                            itemBuilder: (context, index) {
                              return TaskContainer(
                                taskData: state.task[index],
                                index: index,
                              );
                            },
                          ),
                        );
                } else {
                  return Center(
                    child: Text(
                      "Something went wrong!",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      drawer: const CommonDrawer(),
    );
  }
}
