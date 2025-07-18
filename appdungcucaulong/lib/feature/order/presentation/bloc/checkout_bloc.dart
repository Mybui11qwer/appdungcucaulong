import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/order_entity.dart';
import '../../domain/usecase/create_order_usecase.dart';

sealed class CheckoutEvent {}

class SubmitOrderEvent extends CheckoutEvent {
  final int customerId;
  final List<Map<String, dynamic>> products;
  final double total;
  final String paymentMethod;
  final String shippingAddress;
  final int? saleId;

  SubmitOrderEvent({
    required this.customerId,
    required this.products,
    required this.total,
    required this.paymentMethod,
    required this.shippingAddress,
    this.saleId,
  });
}

sealed class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final OrderEntity order;
  CheckoutSuccess(this.order);
}

class CheckoutFailure extends CheckoutState {
  final String message;
  CheckoutFailure(this.message);
}

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CreateOrderUseCase createOrder;

  CheckoutBloc(this.createOrder) : super(CheckoutInitial()) {
    on<SubmitOrderEvent>((event, emit) async {
      emit(CheckoutLoading());
      try {
        final order = await createOrder(
          event.customerId,
          event.products,
          total: event.total,
          paymentMethod: event.paymentMethod,
          shippingAddress: event.shippingAddress,
          saleId: event.saleId,
        );
        emit(CheckoutSuccess(order));
      } catch (e) {
        emit(CheckoutFailure(e.toString()));
      }
    });
  }
}
