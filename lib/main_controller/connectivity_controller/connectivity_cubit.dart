part of '../main_controller.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit({required this.internetAdaptor})
      : super(InternetInitial()) {
    connectivityStream = internetAdaptor.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        emitInternetConnected();
      } else {
        emitInternetDisconnected();
      }
    });
  }

  final Connectivity internetAdaptor;
  late StreamSubscription connectivityStream;

  void emitInternetConnected() => emit(InternetConnected());

  void emitInternetDisconnected() => emit(NoInternetConnections());

  @override
  Future<void> close() {
    connectivityStream.cancel();
    return super.close();
  }
}
