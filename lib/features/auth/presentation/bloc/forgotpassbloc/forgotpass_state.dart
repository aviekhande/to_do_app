part of 'forgotpass_bloc.dart';

sealed class ForgotPassState {}

final class ForgotPassInitial extends ForgotPassState {}

class ForgotPassSuccess extends ForgotPassState{}

class ForgotPassFailed extends ForgotPassState{}
class ForgotPassLoading extends ForgotPassState{}
