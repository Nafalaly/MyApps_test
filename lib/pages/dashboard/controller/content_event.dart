part of '../../pages.dart';

abstract class ContentStatus {
  const ContentStatus();
}

class InitialStatus extends ContentStatus {
  const InitialStatus();
}

class ContentReloading extends ContentStatus {
  const ContentReloading();
}

class ContentSuccesfullyLoaded extends ContentStatus {
  const ContentSuccesfullyLoaded();
}

class ContentFailedToLoad extends ContentStatus {
  final String failMessage;
  ContentFailedToLoad({required this.failMessage});
}
