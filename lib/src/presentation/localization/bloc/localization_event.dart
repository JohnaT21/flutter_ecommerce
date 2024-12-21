// ignore_for_file: must_be_immutable

part of 'localization_bloc.dart';

@immutable
abstract class LocalizationEvent {}

class ChangeLocale extends LocalizationEvent{
  Locale locale;
  ChangeLocale({required this.locale});
}

class GetLocale extends LocalizationEvent{
}
