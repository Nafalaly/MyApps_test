part of '../main_controller.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountDettached extends AccountState {}

class AccountAttached extends AccountState {
  final Account account;
  AccountAttached({required this.account});
  AccountAttached copyWith({required Account? account}) {
    return AccountAttached(account: account ?? this.account);
  }
}
