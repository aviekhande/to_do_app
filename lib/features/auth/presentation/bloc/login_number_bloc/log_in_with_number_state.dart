part of 'log_in_with_number_bloc.dart';

 class LogInWithNumberState {}

 class LogInWithNumberInitial extends LogInWithNumberState {}
class LoginLoading extends LogInWithNumberState {}
class LoginLoading1 extends LogInWithNumberState {}

class LoginSuccess extends LogInWithNumberState {
  String verificationId;
  LoginSuccess({required this.verificationId});
}

class LoginFailed extends LogInWithNumberState {
  String response;
  LoginFailed({required this.response});
}
class LoginSuccess1 extends LogInWithNumberState {
  String verificationId;
  LoginSuccess1({required this.verificationId});
}
