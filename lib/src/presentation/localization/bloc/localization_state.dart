part of 'localization_bloc.dart';

@immutable
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}

class LocalizationLoading extends LocalizationState{}

// ignore: must_be_immutable
class LocalizationLoaded extends LocalizationState{
  Locale locale;
  LocalizationLoaded({required this.locale});
}

// ignore: must_be_immutable
class LocalizationError extends LocalizationState{
  String message;
  LocalizationError({required this.message});
}
