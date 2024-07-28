import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth/data/auth_remote_datasource.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginevent.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginstate.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<IsUserPresent>(_onFetchData);
    on<LogoutEvent>(_onLogout);
    on<LoginInitial>(_onLoginIni);
  }
  void _onLoginIni(LoginInitial event, Emitter<LoginState> emit) {
    emit(LoginInitialState());
  }

  void _onFetchData(IsUserPresent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    var res = await AuthMethod()
        .loginUser(email: event.email, password: event.password);
    log("$res");
    res[0] ? emit(LoginSuccess()) : emit(LoginFailure(res:res[1]));
  }

  void _onLogout(LogoutEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    AuthMethod().signOut();
    emit(Logout());
    // emit(LoginInitialState());
  }
}
