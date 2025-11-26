import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<GetCartItems>(_onGetCartItems);
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onGetCartItems(GetCartItems event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await cartRepository.getCartItems();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddItemToCart(AddItemToCart event, Emitter<CartState> emit) async {
    await cartRepository.addToCart(event.item);
    add(GetCartItems());
  }

  Future<void> _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<CartState> emit) async {
    await cartRepository.removeFromCart(event.productId);
    add(GetCartItems());
  }

  Future<void> _onUpdateItemQuantity(UpdateItemQuantity event, Emitter<CartState> emit) async {
    await cartRepository.updateItemQuantity(event.productId, event.quantity);
    add(GetCartItems());
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    await cartRepository.clearCart();
    add(GetCartItems());
  }
}
