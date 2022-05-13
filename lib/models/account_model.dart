part of 'models.dart';

class Account {
  late String name;
  late String email;
  late String password;
  late String phone;
  late String uuid;
  Map timeInformation = {
    'created_at': 'No time specifed',
    'timezone_type': 'No timezone type specifed',
    'timezone': 'UTC',
  };
  Account();
  Account.init() {
    uuid = phone = password = email = name = '';
  }
  factory Account.fromJson({required Map jsonData, String? password}) {
    Account newAccount = Account();
    newAccount.name = jsonData['user']['name'];
    newAccount.email = jsonData['user']['email'];
    newAccount.phone = jsonData['user']['phone_number'];
    newAccount.uuid = jsonData['user']['uuid'];
    newAccount.timeInformation = jsonData['user']['created'];
    newAccount.password = password ?? 'No Password Defined';
    return newAccount;
  }
}
