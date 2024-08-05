import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:to_do_app/features/add_task_details/presentation/pages/add_task_dialog.dart';

import '../bloc/bloc/add_tasks_bloc.dart';
// import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar',
          style:
              GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<AddTasksBloc, AddTasksState>(
            builder: (context, state) {
              return state is AddTaskSuccess? SfCalendar(
                allowedViews: const [CalendarView.month, CalendarView.day],
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.indicator,
                    showAgenda: true),
                selectionDecoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                view: CalendarView.month,
                // firstDayOfWeek: 6,
                initialDisplayDate: DateTime.now(),
                initialSelectedDate: DateTime.now(),
                todayTextStyle: const TextStyle(color: Colors.black),
                dataSource: TodoDataSource(getAppointments(state.task)),
              ): const Center(
                      child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ));
            },
          )
          // Column(
          //   children: [
          //     TableCalendar(
          //       firstDay: DateTime.utc(2010, 10, 16),
          //       lastDay: DateTime.utc(2030, 3, 14),
          //       focusedDay: _focusedDay,
          //       calendarFormat: _calendarFormat,
          //       selectedDayPredicate: (day) {
          //         return isSameDay(_selectedDay, day);
          //       },
          //       onDaySelected: (selectedDay, focusedDay) {
          //         setState(() {
          //           _selectedDay = selectedDay;
          //           _focusedDay = focusedDay;
          //         });
          //       },
          //       onFormatChanged: (format) {
          //         if (_calendarFormat != format) {
          //           setState(() {
          //             _calendarFormat = format;
          //           });
          //         }
          //       },
          //       onPageChanged: (focusedDay) {
          //         _focusedDay = focusedDay;
          //       },
          //     ),
          //   ],
          // ),

          ),
    );
  }
}
