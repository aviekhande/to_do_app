
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/widget/authmethod.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupRequest>(_onSignUpRequest);
  }
  Future<void> _onSignUpRequest(SignupRequest event,Emitter <SignupState> emit) async {
        String res = await AuthMethod().signUpUser(email: event.email, password: event.password, name: event.name, lastName: event.lastName, image: event.image);
    res == "success" ? emit(SignupSuccess()):emit(SignupFailed());
  }
}
