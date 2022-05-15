part of '../../pages.dart';

abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;
  LoginUsernameChanged({required this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}

class LoginDismissible extends LoginEvent {}

class PasswordSetVisible extends LoginEvent {
  final bool visibleStatus;
  PasswordSetVisible({required this.visibleStatus});
}

class NavigateToDashBoard extends LoginEvent {
  NavigateToDashBoard();
}
