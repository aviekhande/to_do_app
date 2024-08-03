import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
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
  Color getPriorityColor(String? priority) {
    if (priority == null || priority == "Low") {
      return Colors.green;
    } else if (priority == "High") {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  Text getPriority(String? priority) {
    if (priority == null || priority == "Low") {
      return Text(
        " P3",
        style: GoogleFonts.poppins(
            color: Colors.green, fontSize: 12.sp, fontWeight: FontWeight.w600),
      );
    } else if (priority == "High") {
      return Text(
        " P1",
        style: GoogleFonts.poppins(
            color: Colors.red, fontSize: 12.sp, fontWeight: FontWeight.w600),
      );
    } else {
      return Text(
        " P3",
        style: GoogleFonts.poppins(
            color: Colors.yellow, fontSize: 12.sp, fontWeight: FontWeight.w600),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.only(bottom: 20.h),
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
          GestureDetector(
            onTap: () async {
              log("msg");
              if (!widget.taskData.done!) {
                final player = AudioPlayer();
                var assetSource = AssetSource('done.mp3');
                await player.play(assetSource);
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
                            color: getPriorityColor(widget.taskData.priority))),
                  ),
                  getPriority(widget.taskData.priority)
                ],
              ),
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
