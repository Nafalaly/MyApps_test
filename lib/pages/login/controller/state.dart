part of '../../pages.dart';

class LoginState {
  String username;
  String password;

  bool passwordVisible;
  FormSubmissionStatus formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.passwordVisible = true,
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    bool? passVisible,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      password: password ?? this.password,
      username: username ?? this.username,
      passwordVisible: passVisible ?? passwordVisible,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
