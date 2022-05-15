part of '../../pages.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {
  const FormSubmitting();
}

class SubmissionSuccess extends FormSubmissionStatus {
  final Account? account;
  const SubmissionSuccess({required this.account});
}

class SubmissionFailure extends FormSubmissionStatus {
  final String failMessage;
  SubmissionFailure({required this.failMessage});
}
