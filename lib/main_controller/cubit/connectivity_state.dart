part of 'connectivity_cubit.dart';

@immutable
abstract class ConnectivityState {}

class InternetLoading extends ConnectivityState {}

class InternetConnected extends ConnectivityState {
  InternetConnected();
}

class NoInternetConnections extends ConnectivityState {}
