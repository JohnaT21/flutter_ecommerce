import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/notification_response_model.dart';
import '../../../domain/usecases/notificatio_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUseCase notificationUseCase;
  NotificationBloc({required this.notificationUseCase})
      : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async {
      if (event is LoadNotifications) {
        try {
          emit(NotificationLoading());
          final notifications = await notificationUseCase.getNotifications();
          emit(NotificationLoaded(notifications: notifications.notifications));
        } catch (e) {
          emit(NotificationError(message: e.toString()));
        }
      }
    });
  }
}
