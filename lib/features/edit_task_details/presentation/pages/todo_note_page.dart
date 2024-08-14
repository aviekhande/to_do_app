import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
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
  late quill.QuillController _quillController;

  @override
  void initState() {
    super.initState();

    // Initialize the Quill controller with the existing note content as plain text
    final doc = quill.Document()..insert(0, widget.task.note ?? "");

    _quillController = quill.QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    _quillController.dispose();
    super.dispose();
  }

  void _saveNote() {
    // Convert the Quill document to plain text
    final String noteContent = _quillController.document.toPlainText();

    // Save the updated note content in the task
    context.read<AddTasksBloc>().add(EditTask(
        task: Tasks(
            note: noteContent, // Store the plain text in note
            imp: widget.task.imp,
            alarm: widget.task.alarm,
            task: widget.task.task,
            date: widget.task.date,
            time: widget.task.time,
            priority: widget.task.priority,
            id: widget.task.id,
            done: widget.task.done),
        index: int.parse(widget.task.id!)));

    // Pop the screen
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Container(
                height: 400.h, // Adjust this height as needed
                padding: EdgeInsets.all(8.0),
                color: Colors.white,
                child: quill.QuillEditor.basic(
                  controller: _quillController,
                  configurations: const quill.QuillEditorConfigurations(
                      floatingCursorDisabled: true),
                  // true for view-only mode
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: quill.QuillToolbar.simple(controller: _quillController),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        child: Icon(Icons.save),
      ),
    );
  }
}
