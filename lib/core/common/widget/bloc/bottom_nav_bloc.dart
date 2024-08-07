import 'package:bloc/bloc.dart';


part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitial()) {
    on<ChangeTab>((event, emit) {
      emit(BottomNavIndex(index: event.index));
    });
  }
}
