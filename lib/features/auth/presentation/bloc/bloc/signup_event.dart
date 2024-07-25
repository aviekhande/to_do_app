part of 'signup_bloc.dart';

 class SignupEvent {
}
class SignupRequest extends SignupEvent {
  String email;
  String password;
  String name;
  String lastName;
  String image;
  SignupRequest({required  this.email,required this.password,required this.name,required this.lastName,required this.image,});
}
