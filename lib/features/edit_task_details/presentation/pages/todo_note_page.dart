import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widget/appbar_widget.dart';
import '../../../calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import '../../../home_screen/data/model/task_model.dart';

@RoutePage()
class TodoNotePage extends StatefulWidget {
  Tasks task;
  TodoNotePage({super.key, required this.task});

  @override
  State<TodoNotePage> createState() => _TodoNotePageState();
}

class _TodoNotePageState extends State<TodoNotePage> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    _noteController.text = widget.task.note != null ? widget.task.note! : "";
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final String noteContent = _noteController.text;

    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CustomAppBar(
          title: "Todo",
          isBack: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  context.read<AddTasksBloc>().add(EditTask(
                      task: Tasks(
                          note: _noteController.text,
                          imp: widget.task.imp,
                          alarm: widget.task.alarm,
                          task: widget.task.task,
                          date: widget.task.date,
                          time: widget.task.time,
                          priority: widget.task.priority,
                          id: widget.task.id,
                          done: widget.task.done),
                      index: int.parse(widget.task.id!)));
                },
                cursorColor:
                    Theme.of(context).colorScheme.surface == Colors.white
                        ? Colors.black
                        : Colors.white,
                controller: _noteController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add note',
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
