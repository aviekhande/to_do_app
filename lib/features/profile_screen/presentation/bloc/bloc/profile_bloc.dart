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
    on<ProfileFetchEvent>(_onFetchProfileData);
    on<UpdateRequest>(_onProfileUp);
  }

  void _onProfileUp(UpdateRequest event, Emitter<ProfileState> emit) async {
    log("INProfup");
    emit(UpdateProfileLoading());
    var imageUrl = "";
    try {
      if (event.isImage) {
        imageUrl = event.image;
      } else {
        imageUrl = await uploadPhoto1(File(event.image));
      }
      log("Image uploaded: $imageUrl");

      List res = await UpdateProfile().updateProfile(
          name: event.name,
          lastName: event.lastName,
          email: event.email,
          image: imageUrl);
      if (res[0]) {
        log("Profile updated successfully");
        add(ProfileFetchEvent());
      } else {
        log("Profile update failed: ${res[1]}");
        emit(UpdateProfileFailed(res: res[1]));
      }
    } catch (e) {
      log("Error during profile update: $e");
      emit(UpdateProfileFailed(res: e.toString()));
    }
  }

  void _onFetchProfileData(
      ProfileFetchEvent event, Emitter<ProfileState> emit) async {
    log("INONFetchProf");
    try {
      emit(ProfileLoading());
      DocumentSnapshot? doc = await getUserData();
      if (doc != null) {
        emit(ProfileFetch(docSnap: doc));
      } else {
        emit(ProfileLoadFailed());
      }
    } catch (e) {
      log("Error fetching profile data: $e");
      emit(ProfileLoadFailed());
    }
  }
}
