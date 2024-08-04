// import 'dart:developer';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart'
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
// import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
// import 'package:intl/intl.dart';
// import 'package:to_do_app/flutter_gen/gen_l10n/app_localizations.dart';
// import '../../../../core/common/widget/snackbar_widget.dart';
// import '../../../../core/theme/colors.dart';

// class AddTaskDialog extends StatefulWidget {
//   const AddTaskDialog({super.key});

//   @override
//   State<AddTaskDialog> createState() => _AddTaskDialogState();
// }

// enum PriorityLabel {
//   low('Low', Colors.green),
//   medium('Medium', Colors.yellow),
//   high('High', Colors.red);

//   const PriorityLabel(this.label, this.color);
//   final String label;
//   final Color color;
// }

// class _AddTaskDialogState extends State<AddTaskDialog> {
//   // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
//   TextEditingController taskController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController timeController = TextEditingController();
//   TextEditingController colorController = TextEditingController();
//   GlobalKey<FormState> addKey = GlobalKey();
//   PriorityLabel? selectedPriority;
//   DateTime? selectedDate;
//   String? _formattedDate;
//   TimeOfDay? _selectedTime;
//   String? _formattedTime;
//   void clearDateTime() {
//     setState(() {
//       selectedDate = null;
//       _formattedDate = null;
//       _selectedTime = null;
//       _formattedTime = null;
//     });
//   }

//   String _formatTime(TimeOfDay time) {
//     final hour = time.hourOfPeriod == 0
//         ? 12
//         : time.hourOfPeriod; // Convert 0 to 12 for AM times
//     final minute = time.minute;
//     final period = time.period == DayPeriod.am ? 'AM' : 'PM';
//     return '$hour:${minute.toString().padLeft(2, '0')} $period'; // Add leading zero to minute
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
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
//         _formattedDate = DateFormat('d MMM yyyy').format(selectedDate!);
//         dateController.text = _formattedDate!;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
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
//         timeController.text = _formattedTime!;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: addKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context)!.addYourTask,
//                 style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 16.h),
//               TextFormField(
//                 style: GoogleFonts.poppins(color: Colors.black),
//                 controller: taskController,
//                 decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: kColorTextfieldBordered, width: 1.0),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   filled: true,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide:
//                         const BorderSide(color: kColorLightBlack, width: 1.0),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   focusColor: kColorPrimary,
//                   fillColor: Colors.white,
//                   hintText: AppLocalizations.of(context)!.enterYourTask,
//                   hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Enter Task";
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.h),
//               // GestureDetector(
//               //   onTap: () async {
//               //     DateTime? pickedDate = await showDatePicker(
//               //         context: context,
//               //         initialDate: DateTime.now(),
//               //         firstDate: DateTime(2000),
//               //         lastDate: DateTime(2101),
//               //         builder: (BuildContext context, Widget? child) {
//               //           return Theme(
//               //             data: ThemeData.light().copyWith(
//               //               colorScheme: const ColorScheme.light(
//               //                 primary: Colors.blue,
//               //                 onPrimary: Colors.white,
//               //                 onSurface: Colors.black,
//               //               ),
//               //               dialogBackgroundColor: Colors.white,
//               //             ),
//               //             child: child!,
//               //           );
//               //         });
//               //     log("Selected Date: $pickedDate");
//               //     if (pickedDate != null) {
//               //       setState(() {
//               //         selectedDate = pickedDate;
//               //         _formattedDate =
//               //             DateFormat('d MMM yyyy').format(selectedDate!);
//               //       });
//               //     }
//               //   },
//               //   child: Container(
//               //     height: 45.h,
//               //     padding: EdgeInsets.all(10.h),
//               //     decoration: BoxDecoration(
//               //       color: kColorWhite,
//               //       borderRadius: BorderRadius.circular(8),
//               //       border: Border.all(color: kColorTextfieldBordered),
//               //     ),
//               //     child: Row(
//               //       children: [
//               //         const Icon(
//               //           Icons.calendar_month,
//               //           color: kColorLightBlack,
//               //         ),
//               //         SizedBox(width: 10.w),
//               //         Text(
//               //           _formattedDate ?? "Date",
//               //           style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               // SizedBox(height: 20.h),
//               // GestureDetector(
//               //   onTap: () async {
//               //     final pickedTime = await showTimePicker(
//               //         context: context,
//               //         initialTime: TimeOfDay.now(),
//               //         builder: (BuildContext context, Widget? child) {
//               //           return Theme(
//               //             data: ThemeData.light().copyWith(
//               //               colorScheme: const ColorScheme.light(
//               //                 primary: Colors.blue,
//               //                 onPrimary: Colors.white,
//               //                 onSurface: Colors.black,
//               //               ),
//               //               dialogBackgroundColor: Colors.white,
//               //             ),
//               //             child: child!,
//               //           );
//               //         });
//               //     if (pickedTime != null) {
//               //       setState(() {
//               //         _selectedTime = pickedTime;
//               //         _formattedTime = _formatTime(_selectedTime!);
//               //       });
//               //     }
//               //   },
//               //   child: Container(
//               //     height: 45.h,
//               //     padding: EdgeInsets.all(10.h),
//               //     decoration: BoxDecoration(
//               //       color: kColorWhite,
//               //       borderRadius: BorderRadius.circular(8),
//               //       border: Border.all(color: kColorTextfieldBordered),
//               //     ),
//               //     child: Row(
//               //       children: [
//               //         const Icon(
//               //           Icons.alarm,
//               //           color: kColorLightBlack,
//               //         ),
//               //         SizedBox(width: 10.w),
//               //         Text(
//               //           _formattedTime ?? "Time",
//               //           style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               TextFormField(
//                 onTap: () {
//                   _selectDate(context);
//                 },
//                 style: GoogleFonts.poppins(color: Colors.black),
//                 controller: dateController,
//                 decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: kColorTextfieldBordered, width: 1.0),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   filled: true,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide:
//                         const BorderSide(color: kColorLightBlack, width: 1.0),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   focusColor: kColorPrimary,
//                   fillColor: Colors.white,
//                   hintText: AppLocalizations.of(context)!.date,
//                   hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
//                   border: const OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: const Icon(
//                       Icons.calendar_month,
//                       color: Colors.black,
//                     ),
//                     onPressed: () => _selectDate(context),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select a date';
//                   }
//                   return null;
//                 },
//                 readOnly: true,
//               ),
//               SizedBox(height: 16.0.h),
//               TextFormField(
//                 onTap: () {
//                   _selectTime(context);
//                 },
//                 style: GoogleFonts.poppins(color: Colors.black),
//                 controller: timeController,
//                 decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: kColorTextfieldBordered, width: 1.0),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   filled: true,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide:
//                         const BorderSide(color: kColorLightBlack, width: 1.0),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   focusColor: kColorPrimary,
//                   fillColor: Colors.white,
//                   hintText: AppLocalizations.of(context)!.time,
//                   hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
//                   border: const OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: const Icon(
//                       Icons.alarm,
//                       color: Colors.black,
//                     ),
//                     onPressed: () => _selectTime(context),
//                   ),
//                 ),
//                 readOnly: true,
//               ),
//               SizedBox(
//                 height: 16.h,
//               ),
//               DropdownMenu<PriorityLabel>(
//                 initialSelection: PriorityLabel.low,
//                 controller: colorController,
//                 label: const Text('Priority'),
//                 onSelected: (PriorityLabel? color) {
//                   setState(() {
//                     selectedPriority = color;
//                   });
//                 },
//                 dropdownMenuEntries: PriorityLabel.values
//                     .map<DropdownMenuEntry<PriorityLabel>>(
//                         (PriorityLabel color) {
//                   return DropdownMenuEntry<PriorityLabel>(
//                     value: color,
//                     label: color.label,
//                     enabled: color.label != 'Grey',
//                     style: MenuItemButton.styleFrom(
//                       foregroundColor: color.color,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               if (selectedPriority != null)
//                 Padding(
//                   padding: EdgeInsets.only(top: 8.h),
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: selectedPriority!.color.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Selected Priority: ${selectedPriority!.label}',
//                           style: GoogleFonts.poppins(
//                             color: selectedPriority!.color == Colors.yellow
//                                 ? Colors.black45
//                                 : selectedPriority!.color,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const Spacer(),
//                         Container(
//                           height: 20,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 selectedPriority = null;
//                               });
//                             },
//                             borderRadius: BorderRadius.circular(50),
//                             child: Icon(
//                               Icons.close,
//                               size: 20.sp,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               SizedBox(height: 30.h),

//               GestureDetector(
//                 onTap: () async {
//                   // FocusScope.of(context).unfocus();
//                   if (addKey.currentState!.validate() &&
//                       (_formattedDate != null)) {
//                     FocusScope.of(context).unfocus();
//                     context.read<AddTasksBloc>().add(TaskAdd1(
//                           task: Tasks(
//                               task: taskController.text,
//                               date: _formattedDate,
//                               time: _formattedTime,
//                               id: DateTime.now().toString(),
//                               done: false,
//                               priority: selectedPriority == null
//                                   ? "Low"
//                                   : selectedPriority!.label),
//                         ));
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.only(
//                       left: 50.w, right: 50.w, top: 10, bottom: 10),
//                   decoration: BoxDecoration(
//                     color: kColorPrimary,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Center(
//                     child: Text(
//                       AppLocalizations.of(context)!.addTask,
//                       style: GoogleFonts.poppins(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                         color: kColorWhite,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               BlocConsumer<AddTasksBloc, AddTasksState>(
//                 listener: (context, state) {
//                   if (state is AddTaskSuccess1) {
//                     showSnackBarWidget(context, "Task Added", kColorPrimary);
//                     Navigator.pop(context); // Pop AddTaskScreen
//                     taskController.clear();
//                     clearDateTime();
//                   }
//                 },
//                 builder: (context, state) {
//                   return const SizedBox();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:alarm/alarm.dart';
import 'package:auto_route/auto_route.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/loader_widget.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

enum PriorityLabel {
  low(' P3  Low', Colors.green),
  medium(' P2  Medium', Colors.yellow),
  high(' P1  High', Colors.red);

  const PriorityLabel(this.label, this.color);
  final String label;
  final Color color;
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController alarmController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  GlobalKey<FormState> addKey = GlobalKey();
  PriorityLabel? selectedPriority;
  DateTime? selectedDate;
  String? _formattedDate;
  TimeOfDay? _selectedTime;
  String? _formattedTime;
  TimeOfDay? alarm1;
  void clearDateTime() {
    setState(() {
      taskController.clear();
      dateController.clear();
      timeController.clear();
      selectedDate = null;
      _formattedDate = null;
      _selectedTime = null;
      _formattedTime = null;
    });
  }

  int? uniqIdAlarm;
  int generateUniqueId() {
    DateTime now = DateTime.now();

    // Extract date components
    int year = now.year % 100; // Last two digits of the year
    int month = now.month; // 1-12
    int day = now.day; // 1-31

    // Calculate milliseconds since midnight
    int millisecondsSinceMidnight = now.millisecondsSinceEpoch -
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    // Extract last 4 digits of milliseconds to fit into 10 digits
    int timePart = millisecondsSinceMidnight % 10000;

    // Combine components into a unique ID
    // Year (2 digits), Month (1 digit), Day (2 digits), Time (4 digits)
    int uniqueId = year * 1000000 + month * 100000 + day * 1000 + timePart;

    // Ensure the ID does not exceed 2147483647
    if (uniqueId > 2147483647) {
      uniqueId %= 2147483647; // Wrap around if it exceeds the limit
    }
    uniqIdAlarm = uniqueId;
    return uniqueId;
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
        firstDate: DateTime(2000),
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

  DateTime convertTimeOfDayToDateTime(DateTime date, TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return dateTime;
  }

  Future<void> _selectTime(BuildContext context, bool isReminder) async {
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
    if (isReminder) {
      alarm1 = pickedTime;
    }
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _formattedTime = _formatTime(_selectedTime!);
        isReminder
            ? alarmController.text = _formattedTime!
            : timeController.text = _formattedTime!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: addKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      AutoRouter.of(context).popForced();
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kColorWhite,
                        ),
                        child: SvgPicture.asset("assets/icons/back_ic.svg")),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    AppLocalizations.of(context)!.addYourTask,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    style: GoogleFonts.poppins(color: Colors.black),
                    controller: taskController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: kColorTextfieldBordered, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: kColorLightBlack, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusColor: kColorPrimary,
                      fillColor: Colors.white,
                      hintText: AppLocalizations.of(context)!.enterYourTask,
                      hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        log("Enter Task");
                        return AppLocalizations.of(context)!.enterYourTask;
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
                  //           style: GoogleFonts.poppins(
                  //               fontWeight: FontWeight.w500),
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
                  //           style: GoogleFonts.poppins(
                  //               fontWeight: FontWeight.w500),
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
                        borderSide: const BorderSide(
                            color: kColorLightBlack, width: 1.0),
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
                      _selectTime(context, false);
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
                        borderSide: const BorderSide(
                            color: kColorLightBlack, width: 1.0),
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
                        onPressed: () => _selectTime(context, false),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 16.0.h),
                  TextFormField(
                    onTap: () {
                      _selectTime(context, true);
                    },
                    style: GoogleFonts.poppins(color: Colors.black),
                    controller: alarmController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: kColorTextfieldBordered, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: kColorLightBlack, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusColor: kColorPrimary,
                      fillColor: Colors.white,
                      hintText: AppLocalizations.of(context)!.alarm,
                      hintStyle: GoogleFonts.poppins(color: kColorLightBlack),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.alarm,
                          color: Colors.black,
                        ),
                        onPressed: () => _selectTime(context, true),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  // DropdownMenu<PriorityLabel>(
                  //   initialSelection: PriorityLabel.low,
                  //   controller: colorController,
                  //   label: const Text('Priority'),
                  //   onSelected: (PriorityLabel? color) {
                  //     setState(() {
                  //       selectedPriority = color;
                  //     });
                  //   },
                  //   dropdownMenuEntries: PriorityLabel.values
                  //       .map<DropdownMenuEntry<PriorityLabel>>(
                  //           (PriorityLabel color) {
                  //     return DropdownMenuEntry<PriorityLabel>(
                  //       value: color,
                  //       label: color.label,
                  //       enabled: color.label != 'Grey',
                  //       style: MenuItemButton.styleFrom(
                  //         foregroundColor: color.color,
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                  CustomDropdownButtonFormField(
                    hint: 'Priority',
                    items: PriorityLabel.values,
                    selectedValue: selectedPriority,
                    onChanged: (PriorityLabel? value) {
                      setState(() {
                        selectedPriority = value;
                      });
                    },
                  ),
                  if (selectedPriority != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Container(
                        width: 180.w,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: selectedPriority!.color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 12.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                  color:
                                      selectedPriority!.color.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: selectedPriority!.color)),
                            ),
                            Text(
                              '${selectedPriority!.label}',
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

                  SizedBox(height: 100.h),
                  GestureDetector(
                    onTap: () async {
                      if (addKey.currentState!.validate() &&
                          (_formattedDate != null)) {
                        context.read<AddTasksBloc>().add(TaskAdd1(
                              task: Tasks(
                                  task: taskController.text,
                                  date: _formattedDate,
                                  time: _formattedTime,
                                  id: generateUniqueId().toString(),
                                  done: false),
                            ));
                        AutoRouter.of(context).back();
                        final alarmSettings = AlarmSettings(
                          id: uniqIdAlarm!,
                          dateTime: convertTimeOfDayToDateTime(
                              selectedDate!, alarm1!),
                          assetAudioPath: 'assets/done.mp3',
                          loopAudio: true,
                          vibrate: true,
                          volume: 0.8,
                          fadeDuration: 3.0,
                          notificationTitle: 'Reminder',
                          notificationBody: 'Complete your task',
                          androidFullScreenIntent: true,
                          enableNotificationOnKill: false,
                        );
                        await Alarm.set(alarmSettings: alarmSettings);
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
                ],
              ),
            ),
          ),
          BlocConsumer<AddTasksBloc, AddTasksState>(
            listener: (context, state) {
              if (state is AddTaskSuccess) {
                clearDateTime();
              }
            },
            builder: (context, state) {
              if (state is AddTaskLoading) {
                return const LoaderWidget();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class CustomDropdownButtonFormField extends StatelessWidget {
  final String hint;
  final ValueChanged<PriorityLabel?>? onChanged;
  final PriorityLabel? selectedValue;
  final List<PriorityLabel> items;

  const CustomDropdownButtonFormField({
    super.key,
    required this.hint,
    this.onChanged,
    this.selectedValue,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<PriorityLabel>(
      value: selectedValue,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.white,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        border: const OutlineInputBorder(),
      ),
      items: items.map<DropdownMenuItem<PriorityLabel>>((PriorityLabel value) {
        return DropdownMenuItem<PriorityLabel>(
          value: value,
          child: Row(
            children: [
              Container(
                height: 12.h,
                width: 12.w,
                decoration: BoxDecoration(
                    color: value.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: value.color)),
              ),
              Text(value.label, style: TextStyle(color: value.color)),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
