import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 195, 194, 194),
                blurRadius: 5,
                offset: Offset(0, 3))
          ],
          color: const Color.fromARGB(255, 237, 236, 236),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          const Icon(Icons.check_box_outline_blank),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.taskData.task!,
                style: GoogleFonts.poppins(),
              ),
              Text(
                "${widget.taskData.date}" + "     ${widget.taskData.time}",
                style: GoogleFonts.poppins(),
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                context
                    .read<AddTasksBloc>()
                    .add(TaskDelete(time: widget.taskData.time!));
              },
              child: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
