part of 'theme_bloc_bloc.dart';

sealed class ThemeBlocState {
  ThemeBlocState();
}

final class ThemeBlocInitial extends ThemeBlocState {}

class ThemeChangeBloc extends ThemeBlocState {
  ThemeData themeData = lightMode;
  ThemeChangeBloc({required this.themeData});
}
