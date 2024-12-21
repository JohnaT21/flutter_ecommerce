part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class GetChatlistLoading extends ChatState {}

class GetChatlistSuccess extends ChatState {
  final Map<String, dynamic> chatList;

  GetChatlistSuccess({required this.chatList});
}

class GetChatlistError extends ChatState {
  final String msg;

  GetChatlistError({required this.msg});
}
