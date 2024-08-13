part of 'log_in_with_number_bloc.dart';

@immutable
sealed class LogInWithNumberEvent {}
class LoginRequest extends LogInWithNumberEvent{
  String number;
  BuildContext context;
  LoginRequest({required this.number ,required this.context});
}
class NumberVerify extends LogInWithNumberEvent{
  String verificationId;
  String otp;
  BuildContext context;
  NumberVerify({required this.verificationId ,required this.otp,required this.context});

}
class VerificationFailed extends LogInWithNumberEvent{
  String res;
  VerificationFailed({required this.res});
}
class CodeSent extends LogInWithNumberEvent{
   String verificationId;
   CodeSent({required this.verificationId});
}