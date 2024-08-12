import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/auth_remote_datasource.dart';

part 'log_in_with_number_event.dart';
part 'log_in_with_number_state.dart';

class LogInWithNumberBloc
    extends Bloc<LogInWithNumberEvent, LogInWithNumberState> {
  LogInWithNumberBloc() : super(LogInWithNumberInitial()) {
    on<LoginRequest>(_onRequest);
  }
  void _onRequest(
      LoginRequest event, Emitter<LogInWithNumberState> emit) async {
    emit(LoginLoading());
    await AuthMethod().verifyPhoneNumber(event.number, event.context);
    emit(LoginSuccess());
  }
}
