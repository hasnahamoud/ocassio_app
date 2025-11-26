
import '../../domain/entities/order.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final Order order;
  CheckoutSuccess(this.order);
}

class CheckoutFailure extends CheckoutState {
  final String message;
  CheckoutFailure(this.message);
}
