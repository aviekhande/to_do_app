import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/features/profile_screen/presentation/bloc/bloc/profile_bloc.dart';

import '../../data/update_remote_datasource.dart';

part 'updateprofile_event.dart';
part 'updateprofile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<UpdateRequest>((event, emit) async{
      emit(UpdateProfileLoading());
      List res=await UpdateProfile().updateProfile(
          name: event.name,
          lastName: event.lastName,
          email: event.email,
          image: event.image);

      res[0]?emit(UpdateProfileSuccess()):emit(UpdateProfileFailed(res: res[1]));
    });
  }
}
