import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Cubit<InternetStatus> {
  InternetBloc()
      : super(const InternetStatus(ConnectivityStatus.disconnected)) {
    // on<InternetEvent>(checkInternet);
  }
  void checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(connectivityResult[0]);
  }

  void _updateConnectivityStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      emit(const InternetStatus(ConnectivityStatus.disconnected));
    } else {
      emit(const InternetStatus(ConnectivityStatus.connected));
    }
  }

  late StreamSubscription<List<ConnectivityResult>> _subscription;

  void trackConnectivityChange() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectivityStatus(result[0]);
    });
  }

  void dispose() {
    _subscription.cancel();
  }
}
