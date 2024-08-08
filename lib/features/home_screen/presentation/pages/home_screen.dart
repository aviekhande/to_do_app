import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/snackbar_widget.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/features/home_screen/presentation/widgets/task_container.dart';
import 'package:to_do_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/common/widget/drawer_widget.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/bloc/theme_bloc_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/shimmer_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int? alarmId1;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Alarm.ringStream.stream.listen(
      (event) {
        alarmId1 = event.id;
        log("alarmId:${event.id}");
        showSnackBarWidget(context, "Alarm on of red card", kColorPrimary);
        context.read<AddTasksBloc>().add(TaskAdd());
      },
    );
    context.read<AddTasksBloc>().add(TaskAdd()); // Initial fetch of tasks
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite.w, 50.h),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            AppLocalizations.of(context)!.tasks,
            style: GoogleFonts.poppins(
                fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
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
                Theme.of(context).colorScheme.surface != Colors.grey.shade700
                    ? Icons.sunny
                    : Icons.dark_mode,
                size: 18.h,
                color: Theme.of(context).colorScheme.surface ==
                        Colors.grey.shade700
                    ? Theme.of(context).colorScheme.surface
                    : Colors.amber,
              ),
            ),
            SizedBox(
              width: 20.w,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          BlocConsumer<AddTasksBloc, AddTasksState>(
            listener: (context, state) {
              if (state is TasksDeleteSuccess) {
                showSnackBarWidget(
                    context, "Task deleted", Colors.red.shade700);
              }
              if (state is AddTaskSuccess1) {
                showSnackBarWidget(context, "Task Added", kColorPrimary);
              }
            },
            builder: (context, state) {
              if (state is AddTaskLoading) {
                return Expanded(
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const ShimmerWidget();
                      }),
                );
              } else if (state is AddTaskSuccess) {
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
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: state.task1.length,
                          itemBuilder: (context, index) {
                            return TaskContainer(
                              allList: state.task,
                                tasksMap: state.task1,
                                taskData: state.task[index],
                                index1: index,
                                alarmId: alarmId1);
                          },
                        ),
                      );
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: 8,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const ShimmerWidget();
                      }),
                );
              }
            },
          ),
        ],
      ),
      drawer: const CommonDrawer(
        page: "Home",
      ),
    );
  }
}
