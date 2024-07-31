class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailed extends SignUpState {
  String response;
  SignUpFailed({required this.response});
}

class ProfileSelect extends SignUpState {
  String image;
  ProfileSelect({required this.image});
}

