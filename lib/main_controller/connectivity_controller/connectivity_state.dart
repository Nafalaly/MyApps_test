part of '../main_controller.dart';

@immutable
abstract class ConnectivityState {}

class InternetInitial extends ConnectivityState {
  InternetInitial();
}

class InternetConnected extends ConnectivityState {
  InternetConnected();
}

class NoInternetConnections extends ConnectivityState {
  NoInternetConnections();
}
