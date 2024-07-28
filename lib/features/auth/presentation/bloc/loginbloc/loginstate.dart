class LoginState {}

class LoginInitialState extends LoginState {}

class FetchProfileData extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  String res;
  LoginFailure({required this.res});
}

class Logout extends LoginState {}
