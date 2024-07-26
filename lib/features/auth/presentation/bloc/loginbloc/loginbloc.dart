import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth/data/auth_remote_datasource.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginevent.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginstate.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<IsUserPresent>(_onFetchData);
    on<LogoutEvent>(_onLogout);
  }
  void _onFetchData(IsUserPresent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    String res = await AuthMethod()
        .loginUser(email: event.email, password: event.password);
    res.isNotEmpty ? emit(LoginSuccess()) : emit(LoginFailure());
  }

  void _onLogout(LogoutEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    AuthMethod().signOut();
    emit(Logout());
  }
}
