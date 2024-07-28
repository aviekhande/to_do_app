part of 'profile_bloc.dart';
class ProfileState {
}

final class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {
  DocumentSnapshot docSnap;

  ProfileLoading({required this.docSnap});

}
class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileFailed extends ProfileState {
  String res;
  UpdateProfileFailed({required this.res});
}

