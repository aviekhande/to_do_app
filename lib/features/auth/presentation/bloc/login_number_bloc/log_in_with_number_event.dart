part of 'log_in_with_number_bloc.dart';

@immutable
sealed class LogInWithNumberEvent {}
class LoginRequest extends LogInWithNumberEvent{
  String number;
  BuildContext context;
  LoginRequest({required this.number ,required this.context});
}
