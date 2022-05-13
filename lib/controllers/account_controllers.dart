part of 'controllers.dart';

class AccountController extends GetxController {
  Account _currentAccount = Account.init();

  //get current logged account
  Account getCurrentAccount() => _currentAccount;

  Future<void> loginToAccount({
    required String email,
    required String password,
  }) async {
    APIUser api = APIUser();
    ResponseParser result = await api.loginUser(email: email, pass: password);
    switch (result.getStatusCode) {
      case 200:
        Get.off(() => const Dashboard());
        break;
      default:
        showInternalErrorPopUp(message: result.getMessage!);
        break;
    }
  }

  void setCurrentAccount({required Account newAccount}) {
    _currentAccount = newAccount;
  }
}

enum EventTypes { init, loginAccount, fetchCurrentAccount }

class EventHandler {
  EventTypes type = EventTypes.init;
  Map? data;
}

class AccountControllerBloc {
  AccountControllerBloc() {
    eventStream.listen((EventHandler event) async {
      switch (event.type) {
        case EventTypes.loginAccount:
          await loginToAccount(data: event.data!);
          break;
        default:
          break;
      }
    });
  }
  Account? _currentAccount;
  //Stream Controller
  final _accountStreamController = StreamController<Account>();
  final _eventStreamController = StreamController<EventHandler>();
  //Stream
  Stream<Account> get accountStream => _accountStreamController.stream;
  Stream<EventHandler> get eventStream => _eventStreamController.stream;
  //Sink
  Sink<Account> get accountSink => _accountStreamController.sink;

  Future<int> loginToAccount({required Map data}) async {
    APIUser api = APIUser();
    ResponseParser result =
        await api.loginUser(email: data['email'], pass: data['password']);
    if (result.getStatus == ResponseStatus.success) {
      _currentAccount = Account.fromJson(
          jsonData: result.getData!, password: data['password']);
      accountSink.add(_currentAccount!);
      return 0;
    } else {
      return 1;
    }
  }

  void dispose() {
    _accountStreamController.close();
    _eventStreamController.close();
  }
}
