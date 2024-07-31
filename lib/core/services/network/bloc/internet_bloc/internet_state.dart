part of 'internet_bloc.dart';

enum ConnectivityStatus {connected, disconnected }

class InternetStatus {
  final ConnectivityStatus status;
  const InternetStatus(this.status);
}
