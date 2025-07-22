import '../../domain/entity/order_entity.dart';

abstract class OrderHistoryState {}

class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistoryLoaded extends OrderHistoryState {
  final List<OrderEntity> orders;

  OrderHistoryLoaded(this.orders);
}

class OrderHistoryError extends OrderHistoryState {
  final String message;

  OrderHistoryError(this.message);
}
