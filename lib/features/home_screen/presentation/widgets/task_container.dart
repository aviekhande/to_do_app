import 'dart:developer';
import 'package:alarm/alarm.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import '../../../calender_details/presentation/bloc/recyclebloc/recyclebin_bloc.dart';
import '../../data/model/task_model.dart';

class TaskContainer extends StatefulWidget {
  final Tasks taskData;
  final int index;
  const TaskContainer({super.key, required this.taskData, required this.index});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  Color getPriorityColor(String? priority) {
    if (priority == null || priority == " P3  Low") {
      return Colors.green;
    } else if (priority == " P1  High") {
      log(priority);
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  Text getPriority(String? priority) {
    if (priority == null || priority == " P3  Low") {
      return Text(
        " P3",
        style: GoogleFonts.poppins(
            color: Colors.green, fontSize: 12.sp, fontWeight: FontWeight.w600),
      );
    } else if (priority == " P1  High") {
      return Text(
        " P1",
        style: GoogleFonts.poppins(
            color: Colors.red, fontSize: 12.sp, fontWeight: FontWeight.w600),
      );
    } else {
      return Text(
        " P2",
        style: GoogleFonts.poppins(
            color: Colors.orange, fontSize: 12.sp, fontWeight: FontWeight.w600),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(
            EditTaskPageRoute(task: widget.taskData, index: widget.index));
      },
      child: Dismissible(
        background: Container(
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.only(
            top: 15.w,
            right: 15.w,
            left: 15.w,
          ),
          child: Center(
            child: Text(
              "Delete",
              style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        key: ObjectKey(widget.taskData),
        onDismissed: (direction) async {
          context.read<AddTasksBloc>().add(TaskDelete(id: widget.taskData.id!));

          context
              .read<RecycleBinBloc>()
              .add(AddRecycleTask(tasks: widget.taskData));
        },
        child: Container(
          padding: EdgeInsets.all(10.w),
          margin: EdgeInsets.only(
            top: 15.w,
            right: 15.w,
            left: 15.w,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                if (Theme.of(context).colorScheme.shadow !=
                    const Color.fromARGB(255, 111, 109, 109))
                  BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
              ],
              color:
                  Theme.of(context).colorScheme.surface == Colors.grey.shade700
                      ? Theme.of(context).colorScheme.surface
                      : const Color.fromARGB(255, 238, 245, 238),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () async {
                  log("msg");
                  if (!widget.taskData.done!) {
                    final player = AudioPlayer();
                    var assetSource = AssetSource('done.mp3');
                    await player.play(assetSource);
                    Alarm.stop(int.parse(widget.taskData.id!));
                  }
                  !widget.taskData.done!
                      ? context
                          .read<AddTasksBloc>()
                          .add(TaskDone(id: widget.taskData.id!))
                      : context
                          .read<AddTasksBloc>()
                          .add(TaskUnDone(id: widget.taskData.id!));
                },
                child: !widget.taskData.done!
                    ? const Icon(Icons.circle_outlined)
                    : const Icon(
                        Icons.check_circle_sharp,
                        color: kColorPrimary,
                      ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      !widget.taskData.done!
                          ? Text(
                              widget.taskData.task!,
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                              ),
                            )
                          : Text(widget.taskData.task!,
                              style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2)),
                      Row(
                        children: [
                          widget.taskData.time != null
                              ? Text(
                                  "${widget.taskData.date}" +
                                      "     ${widget.taskData.time}",
                                  style: GoogleFonts.poppins(fontSize: 12.sp),
                                )
                              : Text(
                                  "${widget.taskData.date}",
                                  style: GoogleFonts.poppins(),
                                ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            height: 12.h,
                            width: 12.w,
                            decoration: BoxDecoration(
                                color:
                                    getPriorityColor(widget.taskData.priority)
                                        .withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: getPriorityColor(
                                        widget.taskData.priority))),
                          ),
                          getPriority(widget.taskData.priority)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              widget.taskData.alarm! != ""
                  ? GestureDetector(
                      onTap: () {
                        Alarm.stop(int.parse(widget.taskData.id!));
                      },
                      child: const Icon(Icons.alarm))
                  : const SizedBox(),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                  onTap: () {
                    !widget.taskData.imp!
                        ? context
                            .read<AddTasksBloc>()
                            .add(ImpTask(id: widget.taskData.id!))
                        : context
                            .read<AddTasksBloc>()
                            .add(TaskUnImp(id: widget.taskData.id!));
                  },
                  child: !widget.taskData.imp!
                      ? const Icon(Icons.star_border_outlined)
                      : const Icon(
                          Icons.star_outlined,
                          color: Colors.amber,
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
