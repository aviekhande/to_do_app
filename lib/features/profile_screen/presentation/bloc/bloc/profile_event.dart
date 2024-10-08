part of 'profile_bloc.dart';

class ProfileEvent {}

class ProfileFetchEvent extends ProfileEvent{}

class UpdateRequest extends ProfileEvent {
  String name;
  String lastName;
  String image;
  String email;
  bool isImage;
  UpdateRequest(
      {required this.email,
      required this.image,
      required this.lastName,
      required this.name,
      required this.isImage });
}
