part of 'notify_bloc.dart';

@immutable
abstract class NotifyEvent {}

class NotifyAddEvent extends NotifyEvent {}

class NotifyRemoveEvent extends NotifyEvent {}

class NotifyZeroEvent extends NotifyAddEvent {}

//for cart
abstract class NotifyEventCart {}

class NotificationCartAddEvent extends NotifyEventCart {}

class NotificationRemoveEvent extends NotifyEventCart {}

class NotificationZeroEvent extends NotifyEventCart {}
