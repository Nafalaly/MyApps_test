part of '../../pages.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.accountController}) : super(LoginState()) {
    on(mapEvent);
  }

  final APIUser apiLogin = APIUser();
  final AccountBloc accountController;

  Future<void> mapEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));
    } else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is PasswordSetVisible) {
      emit(state.copyWith(passVisible: event.visibleStatus));
    } else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: const FormSubmitting()));
      if (!_validator(event, emit)) {
        return;
      }
      ResponseParser result =
          await apiLogin.loginUser(email: state.username, pass: state.password);
      switch (result.getStatusCode) {
        case 200:
          Account account = Account.fromJson(jsonData: result.getData!);
          accountController.add(AccountLogIn(newAccount: account));
          emit(state.copyWith(formStatus: SubmissionSuccess(account: account)));

          break;
        default:
          emit(state.copyWith(
              formStatus: SubmissionFailure(failMessage: result.getMessage!)));
          break;
      }
    } else if (event is NavigateToDashBoard) {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    } else if (event is LoginDismissible) {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    }
  }

  bool _validator(LoginEvent event, Emitter<LoginState> emit) {
    if (state.username == '') {
      emit(state.copyWith(
          formStatus: SubmissionFailure(failMessage: 'Email Cannot be empty')));
      emit(state.copyWith(formStatus: const InitialFormStatus()));
      return false;
    }
    if (state.password == '') {
      emit(state.copyWith(
          formStatus:
              SubmissionFailure(failMessage: 'Password Cannot be empty')));
      emit(state.copyWith(formStatus: const InitialFormStatus()));
      return false;
    } else if (state.password.length < 5) {
      emit(state.copyWith(
          formStatus: SubmissionFailure(
              failMessage: 'Password Must be at least 5 characters long')));
      emit(state.copyWith(formStatus: const InitialFormStatus()));
      return false;
    }
    return true;
  }
}
