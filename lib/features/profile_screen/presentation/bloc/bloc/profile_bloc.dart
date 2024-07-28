import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common/widget/upload_photo.dart';
import '../../../../update_account/data/update_remote_datasource.dart';
import '../../../data/get_user_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>(_onFetchProfileData);
   on<UpdateRequest>(_onProfileUp);
  }
  void _onProfileUp(
      UpdateRequest event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoading());
    var imageUrl = "";
    if (event.image.isNotEmpty) {
      imageUrl = await uploadPhoto1(File(event.image));
    }
    log("$imageUrl");
    List res = await UpdateProfile().updateProfile(
        name: event.name,
        lastName: event.lastName,
        email: event.email,
        image: imageUrl);

    res[0]
        ? emit(UpdateProfileSuccess())
        : emit(UpdateProfileFailed(res: res[1]));
  }
  void _onFetchProfileData(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    DocumentSnapshot? doc = await getUserData();
    log("${doc?["name"]}");
    emit(ProfileLoading(docSnap: doc!));
  }
}
