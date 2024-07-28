import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth/presentation/bloc/bloc/signup_event.dart';
import 'package:to_do_app/features/auth/presentation/bloc/bloc/signup_state.dart';
import '../../../../../core/common/widget/upload_photo.dart';
import '../../../data/auth_remote_datasource.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequest>(_onSignUpRequest);
    on<ProfileImageSelect>(_onProfileSelect);
  }
  void _onProfileSelect(ProfileImageSelect event, Emitter<SignUpState> emit) {
    log("InBlocProfile");
    emit(ProfileSelect(image: event.image));
  }

  Future<void> _onSignUpRequest(
      SignUpRequest event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    var imageUrl = "";
    if (event.image.isNotEmpty) {
      imageUrl = await uploadPhoto1(File(event.image));
    }
    List res = await AuthMethod().SignUpUser(
        email: event.email,
        password: event.password,
        name: event.name,
        lastName: event.lastName,
        image: imageUrl);
    log("$res");
    res[0] ? emit(SignUpSuccess()) : emit(SignUpFailed(response: res[1]));
  }
}
