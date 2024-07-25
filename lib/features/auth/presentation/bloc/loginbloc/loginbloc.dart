import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/common/widget/authmethod.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginevent.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginstate.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(LoginInitialState()){
    on<IsUserPresent>(_onFetchData);
  }
  void _onFetchData(IsUserPresent event, Emitter <LoginState> emit)async{
    String res = await AuthMethod().loginUser(email: event.email, password: event.password);
    res == "success" ? emit(LoginSuccess()):emit(LoginFailure());
  }

}