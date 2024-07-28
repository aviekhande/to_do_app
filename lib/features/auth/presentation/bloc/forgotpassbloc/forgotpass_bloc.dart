import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth/data/auth_remote_datasource.dart';

part 'forgotpass_event.dart';
part 'forgotpass_state.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  ForgotPassBloc() : super(ForgotPassInitial()) {
    on<ForgotPassEvent>((event, emit) async {
      emit(ForgotPassLoading());
      var res = await AuthMethod().resetPassword(email: event.email);
      res[0] ? emit(ForgotPassSuccess()) : emit(ForgotPassFailed());
    });
  }
}
