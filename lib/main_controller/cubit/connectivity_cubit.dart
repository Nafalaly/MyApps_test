import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit({required this.internetAdaptor})
      : super(InternetLoading()) {
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
