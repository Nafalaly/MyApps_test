part of 'controllers.dart';

class AccountController extends GetxController {
  Account _currentAccount = Account.init();

  //get current logged account
  Account getCurrentAccount() => _currentAccount;

  Future<int> loginToAccount({
    required String email,
    required String password,
  }) async {
    APIUser api = APIUser();
    return await api.loginUser(email: email, pass: password);
  }

  void setCurrentAccount({required Account newAccount}) {
    _currentAccount = newAccount;
  }
}
