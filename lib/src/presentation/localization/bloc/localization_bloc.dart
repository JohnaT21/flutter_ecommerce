import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../config/local_storage.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationInitial()) {
    on<LocalizationEvent>((event, emit) async {
      if (event is ChangeLocale) {
        try {
          Storage.saveValue("languageCode", event.locale.languageCode);
          Storage.saveValue("countryCode", event.locale.countryCode);
          emit(LocalizationLoaded(locale: event.locale));
        } catch (e) {
          emit(LocalizationError(message: e.toString()));
        }
      } else if (event is GetLocale) {
        try {
          emit(LocalizationLoading());
          final languageCode = await Storage.getValue("languageCode") ?? "en";
          final countryCode = await Storage.getValue("countryCode") ?? "US";
          emit(LocalizationLoaded(locale: Locale(languageCode, countryCode)));
        } catch (e) {
          emit(LocalizationError(message: e.toString()));
        }
      }
    });
  }
}
