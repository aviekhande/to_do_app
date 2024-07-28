class LoginEvent{
}
class IsUserPresent extends LoginEvent{
  String email;
  String password;
  IsUserPresent({required this.email, required this.password});
}
class LogoutEvent extends LoginEvent{}
class LoadingEvent extends LoginEvent{}
class LoginInitial extends LoginEvent{}