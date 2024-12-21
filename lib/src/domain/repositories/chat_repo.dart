import 'package:dartz/dartz.dart';

abstract class ChatRepo {
  Future<Either<String, dynamic>> getChatList();
}
