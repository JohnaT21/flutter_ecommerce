import 'package:bloc/bloc.dart';
import 'package:ecommerce/src/domain/usecases/chat_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUsecase chatUsecase;
  ChatBloc(this.chatUsecase) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is GetChatListEvent) {
        emit(GetChatlistLoading());
        final res = await chatUsecase.getChatList();
        res.fold((l) {
          Logger().d(l);
          emit(GetChatlistError(msg: l.toString()));
        }, (r) {
          Logger().d(r);
          GetChatlistSuccess(chatList: r);
        });
      }
    });
  }
}
