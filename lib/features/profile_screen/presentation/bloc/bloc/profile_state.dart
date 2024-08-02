part of 'profile_bloc.dart';

class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadFailed extends ProfileState {}

class ProfileFetch extends ProfileState {
  DocumentSnapshot docSnap;
  ProfileFetch({required this.docSnap});
}

class ProfileLoading extends ProfileState {}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileFailed extends ProfileState {
  String res;
  UpdateProfileFailed({required this.res});
}
