import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';

import '../../data/model/task_model.dart';

class TaskContainer extends StatefulWidget {
  final Tasks taskData;
  final int index;
  const TaskContainer({super.key, required this.taskData, required this.index});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
          boxShadow: [
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
          GestureDetector(
            onTap: () {
              log("msg");
              !widget.taskData.done!
                  ? context
                      .read<AddTasksBloc>()
                      .add(TaskDone(id: widget.taskData.id!))
                  : context
                      .read<AddTasksBloc>()
                      .add(TaskUnDone(id: widget.taskData.id!));
            },
            child: !widget.taskData.done!
                ? const Icon(Icons.check_box_outline_blank)
                : const Icon(
                    Icons.check_box,
                    color: kColorPrimary,
                  ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.taskData.task!,
                style: GoogleFonts.poppins(fontSize: 16.sp),
              ),
              widget.taskData.time != null
                  ? Text(
                      "${widget.taskData.date}" +
                          "     ${widget.taskData.time}",
                      style: GoogleFonts.poppins(fontSize: 12.sp),
                    )
                  : Text(
                      "${widget.taskData.date}",
                      style: GoogleFonts.poppins(),
                    )
            ],
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                context
                    .read<AddTasksBloc>()
                    .add(TaskDelete(id: widget.taskData.id!));
              },
              child: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
