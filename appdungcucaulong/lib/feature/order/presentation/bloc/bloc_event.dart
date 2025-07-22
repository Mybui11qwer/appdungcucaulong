abstract class OrderHistoryEvent {}

class FetchOrderHistory extends OrderHistoryEvent {
  final int customerId;

  FetchOrderHistory(this.customerId);
}
