import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  final List properties;
  const Failure({this.properties = const <dynamic>[]});
}

// General failures
class ServerFailure extends Failure {
  final String? msg;

  ServerFailure({this.msg});

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
