import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  GlobalKey<FormState> addKey = GlobalKey();
  DateTime? selectedDate;
  String? _formattedDate;
  TimeOfDay? _selectedTime;
  String? _formattedTime;
  void clearDateTime() {
    setState(() {
      selectedDate = null;
      _formattedDate = null;
      _selectedTime = null;
      _formattedTime = null;
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod; // Convert 0 to 12 for AM times
    final minute = time.minute;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:${minute.toString().padLeft(2, '0')} $period'; // Add leading zero to minute
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    log("Selected Date: $pickedDate");
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        _formattedDate = DateFormat('d MMM yyyy').format(selectedDate!);
        dateController.text = _formattedDate!;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _formattedTime = _formatTime(_selectedTime!);
        timeController.text = _formattedTime!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: addKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Add your task",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                style: GoogleFonts.poppins(color: Colors.black),
                controller: taskController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: kColorTextfieldBordered, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kColorLightBlack, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: kColorPrimary,
                  fillColor: Colors.white,
                  hintText: "Enter your task",
                  hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Task";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              // GestureDetector(
              //   onTap: () async {
              //     DateTime? pickedDate = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate: DateTime(2000),
              //         lastDate: DateTime(2101),
              //         builder: (BuildContext context, Widget? child) {
              //           return Theme(
              //             data: ThemeData.light().copyWith(
              //               colorScheme: const ColorScheme.light(
              //                 primary: Colors.blue,
              //                 onPrimary: Colors.white,
              //                 onSurface: Colors.black,
              //               ),
              //               dialogBackgroundColor: Colors.white,
              //             ),
              //             child: child!,
              //           );
              //         });
              //     log("Selected Date: $pickedDate");
              //     if (pickedDate != null) {
              //       setState(() {
              //         selectedDate = pickedDate;
              //         _formattedDate =
              //             DateFormat('d MMM yyyy').format(selectedDate!);
              //       });
              //     }
              //   },
              //   child: Container(
              //     height: 45.h,
              //     padding: EdgeInsets.all(10.h),
              //     decoration: BoxDecoration(
              //       color: kColorWhite,
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: kColorTextfieldBordered),
              //     ),
              //     child: Row(
              //       children: [
              //         const Icon(
              //           Icons.calendar_month,
              //           color: kColorLightBlack,
              //         ),
              //         SizedBox(width: 10.w),
              //         Text(
              //           _formattedDate ?? "Date",
              //           style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 20.h),
              // GestureDetector(
              //   onTap: () async {
              //     final pickedTime = await showTimePicker(
              //         context: context,
              //         initialTime: TimeOfDay.now(),
              //         builder: (BuildContext context, Widget? child) {
              //           return Theme(
              //             data: ThemeData.light().copyWith(
              //               colorScheme: const ColorScheme.light(
              //                 primary: Colors.blue,
              //                 onPrimary: Colors.white,
              //                 onSurface: Colors.black,
              //               ),
              //               dialogBackgroundColor: Colors.white,
              //             ),
              //             child: child!,
              //           );
              //         });
              //     if (pickedTime != null) {
              //       setState(() {
              //         _selectedTime = pickedTime;
              //         _formattedTime = _formatTime(_selectedTime!);
              //       });
              //     }
              //   },
              //   child: Container(
              //     height: 45.h,
              //     padding: EdgeInsets.all(10.h),
              //     decoration: BoxDecoration(
              //       color: kColorWhite,
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: kColorTextfieldBordered),
              //     ),
              //     child: Row(
              //       children: [
              //         const Icon(
              //           Icons.alarm,
              //           color: kColorLightBlack,
              //         ),
              //         SizedBox(width: 10.w),
              //         Text(
              //           _formattedTime ?? "Time",
              //           style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              TextFormField(
                onTap: () {
                  _selectDate(context);
                },
                style: GoogleFonts.poppins(color: Colors.black),
                controller: dateController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: kColorTextfieldBordered, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kColorLightBlack, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: kColorPrimary,
                  fillColor: Colors.white,
                  hintText: "Date",
                  hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
                readOnly: true,
              ),
              SizedBox(height: 16.0.h),
              TextFormField(
                onTap: () {
                  _selectTime(context);
                },
                style: GoogleFonts.poppins(color: Colors.black),
                controller: timeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: kColorTextfieldBordered, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: kColorLightBlack, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusColor: kColorPrimary,
                  fillColor: Colors.white,
                  hintText: "Time (Optional)",
                  hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.alarm,
                      color: Colors.black,
                    ),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                readOnly: true,
              ),
              SizedBox(height: 80.h),

              GestureDetector(
                onTap: () async {
                  // FocusScope.of(context).unfocus();
                  if (addKey.currentState!.validate() &&
                      (_formattedDate != null)) {
                    FocusScope.of(context).unfocus();
                    context.read<AddTasksBloc>().add(TaskAdd1(
                          task: Tasks(
                              task: taskController.text,
                              date: _formattedDate,
                              time: _formattedTime,
                              id: DateTime.now().toString(),
                              done: false),
                        ));
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 50.w, right: 50.w, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Add Task",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: kColorWhite,
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<AddTasksBloc, AddTasksState>(
                listener: (context, state) {
                  if (state is AddTaskSuccess) {
                    // showSnackBarWidget(context, "Task Added");
                    Navigator.pop(context); // Pop AddTaskScreen
                    taskController.clear();
                    clearDateTime();
                  }
                },
                builder: (context, state) {
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
