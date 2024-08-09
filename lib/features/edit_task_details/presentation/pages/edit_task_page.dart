import 'dart:developer';
import 'package:alarm/alarm.dart';
import 'package:auto_route/auto_route.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:to_do_app/core/common/widget/appbar_widget.dart';
import 'package:to_do_app/core/common/widget/loader_widget.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/features/home_screen/data/model/task_model.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class EditTaskPage extends StatefulWidget {
  final Tasks? task;
  final int index;
  const EditTaskPage({super.key, this.task, required this.index});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

enum PriorityLabel {
  low(' P3  Low', Colors.green),
  medium(' P2  Medium', Colors.orange),
  high(' P1  High', Colors.red);

  const PriorityLabel(this.label, this.color);
  final String label;
  final Color color;
}

class _EditTaskPageState extends State<EditTaskPage> {
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

  @override
  void initState() {
    getTaskData();
    super.initState();
  }

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

  PriorityLabel getPriorityLabel(String? priority) {
    if (priority == null || priority == " P3  Low") {
      return PriorityLabel.low;
    } else if (priority == " P1  High") {
      log(priority);
      return PriorityLabel.high;
    } else {
      return PriorityLabel.medium;
    }
  }

  void getTaskData() {
    taskController.text = "${widget.task!.task}";
    dateController.text = "${widget.task!.date}";
    timeController.text = "${widget.task!.time}";
    alarmController.text = "${widget.task!.alarm}";
    selectedPriority = getPriorityLabel(widget.task!.priority);
  }

  int? uniqIdAlarm;
  int generateUniqueId() {
    DateTime now = DateTime.now();

    //  date components
    int year = now.year % 100; // Last two digits of the year
    int month = now.month; // 1-12
    int day = now.day; // 1-31

    int millisecondsSinceMidnight = now.millisecondsSinceEpoch -
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    int timePart = millisecondsSinceMidnight % 10000;

    int uniqueId = year * 1000000 + month * 100000 + day * 1000 + timePart;

    if (uniqueId > 2147483647) {
      uniqueId %= 2147483647; // Wrap around if it exceeds the limit
    }
    uniqIdAlarm = uniqueId;
    return uniqueId;
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:${minute.toString().padLeft(2, '0')} $period';
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

  DateTime convertTimeOfDayToDateTime(String dateStr, String timeStr) {
    DateFormat dateFormat = DateFormat('d MMM yyyy');
    DateTime date = dateFormat.parse(dateStr);

    TimeOfDay time = TimeOfDay.fromDateTime(DateFormat.jm().parse(timeStr));

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
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
      appBar: PreferredSize(
          preferredSize: Size(10.w, 50.h),
          child: CustomAppBar(
            title: AppLocalizations.of(context)!.editTask,
            isBack: true,
          )),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: addKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      hintStyle: GoogleFonts.poppins(
                          color: kColorLightBlack, fontSize: 16.sp),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim() == "") {
                        log("Enter Task");
                        return AppLocalizations.of(context)!.enterYourTask;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
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
                      hintStyle: GoogleFonts.poppins(
                          color: kColorLightBlack, fontSize: 16.sp),
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
                      hintStyle: GoogleFonts.poppins(
                          color: kColorLightBlack, fontSize: 16.sp),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.alarm,
                          color: Colors.black,
                        ),
                        onPressed: () => _selectTime(context, false),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a time';
                      }
                      return null;
                    },
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
                      hintStyle: GoogleFonts.poppins(
                          color: kColorLightBlack, fontSize: 16.sp),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.add_alarm_outlined,
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
                              selectedPriority!.label,
                              style: GoogleFonts.poppins(
                                color: selectedPriority!.color,
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
                      if ((addKey.currentState!.validate() &&
                              (dateController.text.isNotEmpty)) &&
                          taskController.text.trim() != "") {
                        context.read<AddTasksBloc>().add(EditTask(
                            task: Tasks(
                                imp: widget.task!.imp,
                                alarm: alarmController.text,
                                task: taskController.text,
                                date: dateController.text,
                                time: timeController.text,
                                priority: selectedPriority?.label,
                                id: widget.task!.id,
                                done: widget.task!.done),
                            index: int.parse(widget.task!.id!)));
                        AutoRouter.of(context).back();
                        if (alarm1 != null) {
                          final alarmSettings = AlarmSettings(
                            id: int.parse(widget.task!.id!),
                            dateTime: convertTimeOfDayToDateTime(
                                dateController.text, alarmController.text),
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
                          AppLocalizations.of(context)!.submit,
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
              if (state is AddTaskSuccess1) {
                // AutoRouter.of(context).back();
                taskController.clear();
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
        hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 16.sp),
        border: const OutlineInputBorder(),
      ),
      hint: Center(
        child: Text(
          hint,
          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16.sp),
        ),
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
                  border: Border.all(color: value.color),
                ),
              ),
              SizedBox(
                  width: 8.w), // Add some spacing between the circle and text
              Text(value.label, style: TextStyle(color: value.color)),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

DateTime getDateTime(String dateString, String timeString) {
  DateTime parsedDate = DateFormat("dd MMM yyyy").parse(dateString);
  DateTime parsedTime = DateFormat("h:mm a").parse(timeString);

  DateTime combinedDateTime = DateTime(
    parsedDate.year,
    parsedDate.month,
    parsedDate.day,
    parsedTime.hour,
    parsedTime.minute,
  );
  return combinedDateTime;
}

List<Appointment> getAppointments(List task) {
  List<Appointment> meetings = <Appointment>[];
  for (int i = 0; i < task.length; i++) {
    final DateTime startTime = getDateTime(task[i].date, task[i].time);
    final endTime = startTime.add(const Duration(hours: 1));
    meetings.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: task[i].task,
        color: kColorPrimary));
  }
  return meetings;
}

class TodoDataSource extends CalendarDataSource {
  TodoDataSource(List<Appointment> source) {
    appointments = source;
  }
}
