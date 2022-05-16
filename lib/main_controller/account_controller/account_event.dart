part of '../main_controller.dart';

@immutable
abstract class AccountEvent {}

// ignore: must_be_immutable
class AccountLogIn extends AccountEvent {
  Account newAccount;
  AccountLogIn({required this.newAccount});
}

class AccountLogOut extends AccountEvent {}
