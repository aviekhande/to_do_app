part of 'locbloc_bloc.dart';

sealed class LocState {

}

final class LocInitial extends LocState {}
class ChangeState extends LocState{
  Locale loc;
  ChangeState({required this.loc});
}
