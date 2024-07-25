import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/get_user_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>(_onFetchProfileData);
  }
  void _onFetchProfileData(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    DocumentSnapshot? doc = await getUserData();
    log("${doc?["name"]}");
    emit(ProfileLoading(docSnap: doc!));
  }
}
