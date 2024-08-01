import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/common/widget/snackbar_widget.dart';
import '../../../../core/theme/colors.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

enum PriorityLabel {
  low('Low', Colors.green),
  medium('Medium', Colors.yellow),
  high('High', Colors.red);

  const PriorityLabel(this.label, this.color);
  final String label;
  final Color color;
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  GlobalKey<FormState> addKey = GlobalKey();
  PriorityLabel? selectedPriority;
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
              Text(
                AppLocalizations.of(context)!.addYourTask,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16.h),
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
                  hintText: AppLocalizations.of(context)!.enterYourTask,
                  hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Task";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
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
                  hintText: AppLocalizations.of(context)!.date,
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
                  hintText: AppLocalizations.of(context)!.time,
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
              SizedBox(
                height: 16.h,
              ),
              DropdownMenu<PriorityLabel>(
                initialSelection: PriorityLabel.low,
                controller: colorController,
                label: const Text('Priority'),
                onSelected: (PriorityLabel? color) {
                  setState(() {
                    selectedPriority = color;
                  });
                },
                dropdownMenuEntries: PriorityLabel.values
                    .map<DropdownMenuEntry<PriorityLabel>>(
                        (PriorityLabel color) {
                  return DropdownMenuEntry<PriorityLabel>(
                    value: color,
                    label: color.label,
                    enabled: color.label != 'Grey',
                    style: MenuItemButton.styleFrom(
                      foregroundColor: color.color,
                    ),
                  );
                }).toList(),
              ),
              if (selectedPriority != null)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: selectedPriority!.color.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Selected Priority: ${selectedPriority!.label}',
                          style: GoogleFonts.poppins(
                            color: selectedPriority!.color == Colors.yellow
                                ? Colors.black45
                                : selectedPriority!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedPriority = null;
                              });
                            },
                            borderRadius: BorderRadius.circular(50),
                            child: Icon(
                              Icons.close,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 30.h),

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
                              done: false,
                              priority: selectedPriority == null
                                  ? "Low"
                                  : selectedPriority!.label),
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
                      AppLocalizations.of(context)!.addTask,
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
                  if (state is AddTaskSuccess1) {
                    showSnackBarWidget(context, "Task Added");
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
