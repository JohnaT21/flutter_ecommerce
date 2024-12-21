part of 'option_values_bloc.dart';

abstract class OptionValuesEvent extends Equatable {
  const OptionValuesEvent();

  @override
  List<Object> get props => [];
}
class ChangeOptionValueEvent extends OptionValuesEvent {
  final Option option;
  const ChangeOptionValueEvent({required this.option});

  @override
  List<Object> get props => [];
}
class RemoveOptionValueEvent extends OptionValuesEvent {
  final Option option;
  const RemoveOptionValueEvent({required this.option});

  @override
  List<Object> get props => [];
}