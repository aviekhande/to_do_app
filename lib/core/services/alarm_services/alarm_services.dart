import 'dart:async';
import 'dart:developer';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/common/widget/snackbar_widget.dart';
import 'package:to_do_app/core/theme/colors.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';

import '../../../features/home_screen/presentation/pages/home_screen.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  StreamController<AlarmSettings>? _controller;
  StreamSubscription<AlarmSettings>? _subscription;

  factory AlarmService() {
    return _instance;
  }

  AlarmService._internal();

  // Initialize the StreamController as a broadcast stream
  void initialize() {
    if (_controller == null || _controller!.isClosed) {
      _controller = StreamController<AlarmSettings>.broadcast();
      Alarm.ringStream.stream.listen((event) {
        _controller?.add(event);
      });
    }
  }

  // Method to start listening to the stream
  void startListening(BuildContext context) {
    if (_subscription == null || _subscription!.isPaused) {
      _subscription = _controller!.stream.listen(
        (event) {
          alarmId1 = event.id;
          log("alarmId:${event.id}");
          showSnackBarWidget(
              context, "Please complete the task", kColorPrimary);
          context.read<AddTasksBloc>().add(TaskAdd());
        },
      );
    }
  }

  // Method to stop listening to the stream
  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  // Dispose method to close the stream controller
  void dispose() {
    _controller?.close();
  }

  // Reset the service (useful for logout)
  void resetService() {
    stopListening();
    dispose();
  }
}
