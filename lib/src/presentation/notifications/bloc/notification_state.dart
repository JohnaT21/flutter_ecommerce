part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoaded extends NotificationState {
  final List<Notifications> notifications;
  const NotificationLoaded({required this.notifications,});

  @override
  List<Object> get props => [notifications];
}

class NotificationError extends NotificationState{
  final String message;

  const NotificationError({required this.message});

  @override
  List<Object> get props => [message];
}
