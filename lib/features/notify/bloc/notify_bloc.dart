import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'notify_event.dart';
part 'notify_state.dart';

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  NotifyBloc() : super(const NotifyInitial()) {
    on<NotifyAddEvent>((event, emit) {
      emit(NotifyState(notifyCount: state.notifyCount + 1));
    });

    on<NotifyRemoveEvent>((event, emit) {
      emit(NotifyState(notifyCount: state.notifyCount - 1));
    });

    on<NotifyZeroEvent>((event, emit) {
      emit(const NotifyInitial());
    });
  }
}

class NotifyCartBloc extends Bloc<NotifyEventCart, NotifyStateForCart> {
  NotifyCartBloc() : super(const NotificationInitialCart()) {
    on<NotificationCartAddEvent>((event, emit) {
      emit(NotifyStateForCart(notifyCount: state.notifyCount + 1));
    });

    on<NotificationRemoveEvent>((event, emit) {
      emit(NotifyStateForCart(notifyCount: state.notifyCount - 1));
    });

    on<NotificationZeroEvent>((event, emit) {
      emit(const NotificationInitialCart());
    });
  }
}
