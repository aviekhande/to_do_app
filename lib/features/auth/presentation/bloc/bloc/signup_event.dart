class SignUpEvent {}

class SignUpRequest extends SignUpEvent {
  String email;
  String password;
  String name;
  String lastName;
  String image;
  SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.lastName,
    required this.image,
  });
}

class ProfileImageSelect extends SignUpEvent {
  String image;
  ProfileImageSelect({required this.image});
}

class ProfileImageSuccessEvent extends SignUpEvent {}
