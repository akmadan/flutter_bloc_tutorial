part of 'notify_bloc.dart';

@immutable
class NotifyState {
  final int notifyCount;
  const NotifyState({required this.notifyCount});
}

class NotifyInitial extends NotifyState {
  const NotifyInitial() : super(notifyCount: 0);
}

class NotifyStateForCart {
  final int notifyCount;
  const NotifyStateForCart({required this.notifyCount});
}

class NotificationInitialCart extends NotifyStateForCart {
  const NotificationInitialCart() : super(notifyCount: 0);
}
