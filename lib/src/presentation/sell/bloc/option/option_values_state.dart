part of 'option_values_bloc.dart';

 class OptionValuesState extends Equatable {
  final List<Option> options;
  const OptionValuesState({required this.options});

  @override
  List<Object> get props => [options];
}

