part of 'bottom_nav_bloc.dart';

class BottomNavState {}

final class BottomNavInitial extends BottomNavState {}
class BottomNavIndex extends BottomNavState{
  int index;
  BottomNavIndex({required this.index});
}
