
import 'dart:ui';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'locbloc_event.dart';
part 'locbloc_state.dart';

class LocBloc extends HydratedBloc<LocEvent, LocState> {
  LocBloc() : super(LocInitial()) {
    on<ChangeLang>((event, emit) {
      emit(ChangeState(loc: event.loc));
    });
  }
  @override
   ChangeState? fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      return ChangeState(
        loc: Locale(
          json['value']['languageCode'],
          json['value']['countryCode'],
        ),
      );
    }
    return ChangeState(loc: const Locale('en'));
  }

  @override
  Map<String, dynamic>? toJson(LocState state) {
    if (state is ChangeState) {
      return {
        "value": {
          "languageCode": state.loc.languageCode,
          "countryCode": state.loc.countryCode,
        }
      };
    }
    return {"value": ""};
  }
}
