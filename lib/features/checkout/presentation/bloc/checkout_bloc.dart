import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/data/repositories/cart_repository.dart';
import '../../domain/repositories/checkout_repository.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepository checkoutRepository;
  final CartRepository cartRepository; // لاستخدامه لمسح السلة

  CheckoutBloc({required this.checkoutRepository, required this.cartRepository}) : super(CheckoutInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    try {
      final order = await checkoutRepository.createOrder(
        items: event.items,
        totalAmount: event.totalAmount,
        paymentMethod: event.paymentMethod,
      );
      await cartRepository.clearCart(); // مسح السلة بعد إنشاء الطلب بنجاح
      emit(CheckoutSuccess(order));
    } catch (e) {
      print('Caught an error in Bloc: $e');
      emit(CheckoutFailure(e.toString()));
    }
  }
}
