part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class LoadNotifications extends NotificationEvent {

  const LoadNotifications();

  @override
  List<Object?> get props => [];
}