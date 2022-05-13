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
    if (result.getStatus == ResponseStatus.success) {
      setCurrentAccount(
          newAccount:
              Account.fromJson(jsonData: result.getData!, password: password));
    }
    switch (result.getStatusCode) {
      case 200:
        Get.off(() => Dashboard());
        break;
      case 501:
        showDefaultConnectionProblem();
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
