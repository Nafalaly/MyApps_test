part of '../main_controller.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on(mapEvent);
  }

  Future<void> mapEvent(AccountEvent event, Emitter<AccountState> emit) async {
    if (event is AccountInitial) {
    } else if (event is AccountLogIn) {
      emit(AccountAttached(account: event.newAccount));
    } else {
      emit(AccountDettached());
    }
  }
}
