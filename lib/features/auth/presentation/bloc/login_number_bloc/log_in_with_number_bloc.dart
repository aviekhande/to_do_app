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
    on<NumberVerify>(_onVerify);
    on<CodeSent>(_onCodeSent);
    on<VerificationFailed>(_onFailed);
  }
  void _onFailed(VerificationFailed event, Emitter<LogInWithNumberState> emit) {
    emit(LoginFailed(response: event.res));
  }
  void _onCodeSent(CodeSent event, Emitter<LogInWithNumberState> emit) {
    emit(LoginSuccess(verificationId: event.verificationId));
  }
  void _onRequest(
      LoginRequest event, Emitter<LogInWithNumberState> emit) async {
    emit(LoginLoading());
    await AuthMethod().verifyPhoneNumber(event.number, event.context);
  }



  void _onVerify(NumberVerify event, Emitter<LogInWithNumberState> emit) async {
    emit(LoginLoading1());
    final res= await AuthMethod()
        .signInWithOTP(event.verificationId, event.otp, event.context);
    res == "success"?emit(LoginSuccess1(verificationId: event.verificationId)):emit(LoginFailed(response: res));
  }
}
