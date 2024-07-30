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
  void _onProfileUp(UpdateRequest event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoading());
    var imageUrl = "";
    if (!event.isImage) {
      log("Imageisalrady:${event.isImage}2");
      imageUrl = await uploadPhoto1(File(event.image));
    } else {
      imageUrl = event.image;
    }
  
    List res = await UpdateProfile().updateProfile(
        name: event.name,
        lastName: event.lastName,
        email: event.email,
        image: imageUrl);
    if (res[0]) {
      log("INOnProfileup}");
      DocumentSnapshot? doc = await getUserData();
      emit(ProfileLoading(docSnap: doc!));
      // emit(UpdateProfileSuccess());
    } else {
      emit(UpdateProfileFailed(res: res[1]));
    }
  }

  void _onFetchProfileData(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    DocumentSnapshot? doc = await getUserData();
    emit(ProfileLoading(docSnap: doc!));
  }
}
