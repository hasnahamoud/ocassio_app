import '../../../cart/domain/entities/cart_item.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../data_sources/checkout_remote_data_source.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;

  CheckoutRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Order> createOrder({
    required List<CartItem> items,
    required double totalAmount,
    required String paymentMethod,
  }) async {
    return await remoteDataSource.createOrder(
      items: items,
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
    );
  }
}
