import 'package:dartz/dartz.dart';

import '../repositories/chat_repo.dart';

class ChatUsecase {
  final ChatRepo chatRepo;

  ChatUsecase({required this.chatRepo});
  Future<Either<String, dynamic>> getChatList() {
    return chatRepo.getChatList();
  }
}
