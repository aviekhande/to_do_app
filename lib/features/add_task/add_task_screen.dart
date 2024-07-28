import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/session_controller.dart';
import '../../core/theme/colors.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  TextEditingController taskController = TextEditingController();
  GlobalKey<FormState> addKey = GlobalKey();
  DateTime? selectedDate;
  String? _formattedDate;
  TimeOfDay? _selectedTime;
  String? _formattedTime;
  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod; // Convert 0 to 12 for AM times
    final minute = time.minute;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            // AutoRouter.of(context).popForced();
          },
          child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kColorWhite,
              ),
              child: SvgPicture.asset("assets/icons/back_ic.svg")),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: addKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add your task",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
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
                    hintStyle: GoogleFonts.poppins(color: kColorLightBlack)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Task";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      selectedDate = selectedDate;
                      _formattedDate =
                          DateFormat('d MMM yyyy').format(selectedDate!);
                    });
                  }
                },
                child: Container(
                  height: 45.h,
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    color: kColorWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kColorTextfieldBordered),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: kColorLightBlack,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        _formattedDate ?? "Date",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      _selectedTime = selectedTime;
                      _formattedTime = _formatTime(_selectedTime!);
                    });
                  }
                },
                child: Container(
                  height: 45.h,
                  padding: EdgeInsets.all(10.h),
                  decoration: BoxDecoration(
                    color: kColorWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kColorTextfieldBordered),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                        color: kColorLightBlack,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        _formattedTime ?? "Time",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100.h),
              GestureDetector(
                onTap: () async {
                  if (addKey.currentState!.validate()) {
                    await _fireStore
                        .collection("todo")
                        .doc(SessionController().userId)
                        .set({
                      'task': taskController.text,
                      'date': _formattedDate,
                      'time': _formattedTime,
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 50.w, right: 50.w, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: kColorPrimary,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                      child: Text(
                    "Add Task",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: kColorWhite),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: const CommonFloatingActionButton(),
      // bottomNavigationBar: const Commonbottomnavigationbar(),
    );
  }
}
