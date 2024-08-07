part of 'bottom_nav_bloc.dart';

class BottomNavEvent {}
class ChangeTab extends BottomNavEvent {
  int index;
  ChangeTab({required this.index});
}
