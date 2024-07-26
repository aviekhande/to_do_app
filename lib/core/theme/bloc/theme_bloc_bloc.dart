import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../app_theme.dart';
part 'theme_bloc_event.dart';
part 'theme_bloc_state.dart';

class ThemeBlocBloc extends HydratedBloc<ThemeBlocEvent, ThemeBlocState> {
  ThemeBlocBloc() : super(ThemeBlocInitial()) {
    on<ThemeBlocEvent>((event, emit) {
      log("intheme");
      emit(ThemeChangeBloc(themeData: event.themeData));
    });
  }

  @override
  ThemeChangeBloc? fromJson(Map<String, dynamic> json) {
    // Here you would deserialize your JSON into a ThemeData object.
    try {
      final bool isDarkMode = json['isDarkMode'] as bool;
      return ThemeChangeBloc(
        themeData: isDarkMode ? darkMode : lightMode,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeBlocState state) {
    // Here you would serialize your ThemeData object into a JSON-friendly format.
    if (state is ThemeChangeBloc) {
      return {
        'isDarkMode': state.themeData == darkMode,
      };
    }
    return null;
  }
}
