import 'package:ecommerce/src/presentation/sell/pages/sell_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../../domain/entities/add_product_model.dart';

part 'option_values_event.dart';
part 'option_values_state.dart';

class OptionValuesBloc extends Bloc<OptionValuesEvent, OptionValuesState> {
  OptionValuesBloc() : super(const OptionValuesState(options: [])) {
    on<OptionValuesEvent>((event, emit) {
      if (event is ChangeOptionValueEvent) {
        Logger().d(event.option.toJson());
        emit(OptionValuesState(options: [...state.options, event.option]));
        Logger().d(event.option.toJson());
      }
      if (event is RemoveOptionValueEvent) {
        Logger().d(event.option.toJson());
        for (var element in state.options) {
          if (element.id == event.option.id) {
            state.options.remove(element);
          }
        }
        emit(OptionValuesState(options: [...state.options]));
        Logger().d(event.option.toJson());
      }
    });
  }
}
