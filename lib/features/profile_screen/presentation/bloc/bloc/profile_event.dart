part of 'profile_bloc.dart';
class ProfileEvent {}
class UpdateRequest extends ProfileEvent {
  String name;
  String lastName;
  String image;
  String email;
  UpdateRequest(
      {required this.email,
      required this.image,
      required this.lastName,
      required this.name});
}
