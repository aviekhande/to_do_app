// import 'dart:developer';
// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import '../../../../core/common/widget/upload_photo.dart';
// import '../../data/update_remote_datasource.dart';
// part 'updateprofile_event.dart';
// part 'updateprofile_state.dart';

// class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
//   UpdateProfileBloc() : super(UpdateProfileInitial()) {
//     on<UpdateRequest>(_onProfileUp);
//   }
//       void _onProfileUp(UpdateRequest event, Emitter <UpdateProfileState>emit) async {
//       emit(UpdateProfileLoading());
//       var imageUrl = "";
//       if (event.image.isNotEmpty) {
//         imageUrl = await uploadPhoto1(File(event.image));
//       }
//       log("$imageUrl");
//       List res = await UpdateProfile().updateProfile(
//           name: event.name,
//           lastName: event.lastName,
//           email: event.email,
//           image: imageUrl);

//       res[0]
//           ? emit(UpdateProfileSuccess())
//           : emit(UpdateProfileFailed(res: res[1]));
//     }
//   }

