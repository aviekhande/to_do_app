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
import '../pages/home_screen.dart';

class TaskContainer extends StatefulWidget {
  Tasks taskData;
  int index1;
  int? alarmId;
  List<Tasks> allList;
  Map<String, List<Tasks>> tasksMap;
  TaskContainer(
      {super.key,
      required this.taskData,
      required this.index1,
      this.alarmId,
      required this.tasksMap,
      required this.allList});

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  @override
  void initState() {
    log("IN COntainer: ${widget.alarmId}");
    super.initState();
  }

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

  int getInd(Tasks ta) {
    for (int i = 0; i < widget.allList.length; i++) {
      if (ta.id == widget.allList[i].id) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    log("In build");
    log('In build${widget.alarmId}');
    return Column(
      children: [
        Text("${widget.taskData.date}"),
        ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.tasksMap["${widget.taskData.date}"]!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AutoRouter.of(context).push(EditTaskPageRoute(
                      task: widget.tasksMap["${widget.taskData.date}"]![index],
                      index: getInd(
                          widget.tasksMap["${widget.taskData.date}"]![index])));
                },
                child: Dismissible(
                  background: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
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
                    context.read<AddTasksBloc>().add(TaskDelete(
                        id: widget
                            .tasksMap["${widget.taskData.date}"]![index].id!));

                    context.read<RecycleBinBloc>().add(AddRecycleTask(
                        tasks: widget
                            .tasksMap["${widget.taskData.date}"]![index]));
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
                        color: widget.alarmId !=
                                int.parse(widget
                                    .tasksMap["${widget.taskData.date}"]![index]
                                    .id!)
                            ? Theme.of(context).colorScheme.surface ==
                                    Colors.grey.shade700
                                ? Theme.of(context).colorScheme.surface
                                : const Color.fromARGB(255, 238, 245, 238)
                            : const Color.fromARGB(255, 224, 174, 170),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            log("msg");
                            if (!widget
                                .tasksMap["${widget.taskData.date}"]![index]
                                .done!) {
                              final player = AudioPlayer();
                              var assetSource = AssetSource('done.mp3');
                              await player.play(assetSource);
                              Alarm.stop(int.parse(widget
                                  .tasksMap["${widget.taskData.date}"]![index]
                                  .id!));
                            }
                            !widget.tasksMap["${widget.taskData.date}"]![index]
                                    .done!
                                ? context.read<AddTasksBloc>().add(TaskDone(
                                    id: widget
                                        .tasksMap["${widget.taskData.date}"]![
                                            index]
                                        .id!,
                                    isDone: true))
                                : context.read<AddTasksBloc>().add(TaskUnDone(
                                    id: widget
                                        .tasksMap["${widget.taskData.date}"]![
                                            index]
                                        .id!));
                            if (!widget
                                .tasksMap["${widget.taskData.date}"]![index]
                                .done!) {
                              widget.alarmId = 0;
                              alarmId1 = 0;
                              setState(() {});
                              log('In If${widget.alarmId}');
                            }
                          },
                          child: !widget
                                  .tasksMap["${widget.taskData.date}"]![index]
                                  .done!
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
                                !widget
                                        .tasksMap["${widget.taskData.date}"]![
                                            index]
                                        .done!
                                    ? Text(
                                        widget
                                            .tasksMap[
                                                "${widget.taskData.date}"]![
                                                index]
                                            .task!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                        ),
                                      )
                                    : Text(
                                        widget
                                            .tasksMap[
                                                "${widget.taskData.date}"]![
                                                index]
                                            .task!,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: 2)),
                                Row(
                                  children: [
                                    widget
                                                .tasksMap[
                                                    "${widget.taskData.date}"]![
                                                    index]
                                                .time !=
                                            null
                                        ? Text(
                                            "${widget.tasksMap["${widget.taskData.date}"]![index].date}" +
                                                "     ${widget.tasksMap["${widget.taskData.date}"]![index].time}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp),
                                          )
                                        : Text(
                                            "${widget.tasksMap["${widget.taskData.date}"]![index].date}",
                                            style: GoogleFonts.poppins(),
                                          ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Container(
                                      height: 12.h,
                                      width: 12.w,
                                      decoration: BoxDecoration(
                                          color: getPriorityColor(widget
                                                  .tasksMap[
                                                      "${widget.taskData.date}"]![
                                                      index]
                                                  .priority)
                                              .withOpacity(0.2),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: getPriorityColor(widget
                                                  .tasksMap[
                                                      "${widget.taskData.date}"]![
                                                      index]
                                                  .priority))),
                                    ),
                                    getPriority(widget
                                        .tasksMap["${widget.taskData.date}"]![
                                            index]
                                        .priority)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        widget.tasksMap["${widget.taskData.date}"]![index]
                                    .alarm! !=
                                ""
                            ? GestureDetector(
                                onTap: () {
                                  Alarm.stop(int.parse(widget
                                      .tasksMap["${widget.taskData.date}"]![
                                          index]
                                      .id!));
                                  context.read<AddTasksBloc>().add(TaskDone(
                                      id: widget
                                          .tasksMap["${widget.taskData.date}"]![
                                              index]
                                          .id!,
                                      isDone: false));
                                  if (!widget
                                      .tasksMap["${widget.taskData.date}"]![
                                          index]
                                      .done!) {
                                    widget.alarmId = 0;
                                    alarmId1 = 0;
                                    setState(() {});
                                    log('In If${widget.alarmId}');
                                  }
                                },
                                child: const Icon(Icons.alarm))
                            : const SizedBox(),
                        SizedBox(
                          width: 5.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              !widget
                                      .tasksMap["${widget.taskData.date}"]![
                                          index]
                                      .imp!
                                  ? context.read<AddTasksBloc>().add(ImpTask(
                                      id: widget
                                          .tasksMap["${widget.taskData.date}"]![
                                              index]
                                          .id!))
                                  : context.read<AddTasksBloc>().add(TaskUnImp(
                                      id: widget
                                          .tasksMap["${widget.taskData.date}"]![
                                              index]
                                          .id!));
                            },
                            child: !widget
                                    .tasksMap["${widget.taskData.date}"]![index]
                                    .imp!
                                ? const Icon(Icons.star_border_outlined)
                                : const Icon(
                                    Icons.star_outlined,
                                    color: kColorPrimary,
                                  ))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
