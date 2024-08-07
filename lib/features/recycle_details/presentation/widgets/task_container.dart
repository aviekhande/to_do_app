import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/recyclebloc/recyclebin_bloc.dart';
import '../../../home_screen/data/model/task_model.dart';

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
    return Container(
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
          color: Theme.of(context).colorScheme.surface == Colors.grey.shade700
              ? Theme.of(context).colorScheme.surface
              : const Color.fromARGB(255, 238, 245, 238),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Expanded(
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
                          color: getPriorityColor(widget.taskData.priority)
                              .withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:
                                  getPriorityColor(widget.taskData.priority))),
                    ),
                    getPriority(widget.taskData.priority)
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
              onTap: () {
                context
                    .read<AddTasksBloc>()
                    .add(TaskAdd1(task: widget.taskData));
                context
                    .read<RecycleBinBloc>()
                    .add(RecTaskDelete(id: widget.taskData.id!));
              },
              child: const Icon(Icons.restart_alt_outlined)),
          SizedBox(
            width: 5.w,
          ),
          GestureDetector(
              onTap: () {
                context
                    .read<RecycleBinBloc>()
                    .add(RecTaskDelete(id: widget.taskData.id!));
              },
              child: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
