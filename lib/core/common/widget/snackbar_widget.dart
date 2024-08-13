import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/theme/colors.dart';

import '../../../features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import '../../../features/home_screen/data/model/task_model.dart';

showSnackBarWidget(
  BuildContext context,
  String text, [
  Color color = Colors.black45,
  Tasks? taskData,
]) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 16.sp),
          ),
        ),
        taskData != null
            ? GestureDetector(
                onTap: () {
                  context.read<AddTasksBloc>().add(TaskAdd1(task: taskData));
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: Column(
                  children: [
                    const Icon(
                      Icons.undo_rounded,
                      color: kColorWhite,
                    ),
                    Text(
                      "Undo",
                      style: GoogleFonts.poppins(fontSize: 16.sp),
                    )
                  ],
                ),
              )
            : const SizedBox()
      ],
    ),
  ));
}
