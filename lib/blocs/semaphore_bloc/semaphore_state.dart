part of 'semaphore_bloc.dart';

@immutable
abstract class SemaphoreState {
  final SemaphoreLanguage languageSetting;

  SemaphoreState({required this.languageSetting});
}

class SemaphoreInitial extends SemaphoreState {
  SemaphoreInitial({required super.languageSetting});

  @override
  List<Object> get props => [languageSetting];
}

class SemaphoreLoading extends SemaphoreInitial {
  SemaphoreLoading({required super.languageSetting});
}

class SemaphoreSuccess extends SemaphoreInitial {
  SemaphoreSuccess({required super.languageSetting});
}

class SemaphoreFailure extends SemaphoreInitial {
  final String errorMessage;

  SemaphoreFailure({required this.errorMessage, required super.languageSetting});
}
