import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/product_repository.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository repository;

  ProductsBloc({required this.repository}) : super(ProductsInitial()) {
    on<LoadBirthdayProducts>((event, emit) async {
      emit(ProductsLoading(event.categoryId));
      try {
        final items = await repository.getProductsByCategory(event.categoryId, type: event.type);
        emit(ProductsLoaded(event.categoryId, items));
      } catch (e) {
        emit(ProductsFailure(e.toString(), event.categoryId));
      }
    });
    on<SearchProducts>((event, emit) async {
      emit(ProductsLoading("search_results")); // استخدم ID مميز للبحث
      try {
        final items = await repository.searchProducts(event.query);
        emit(ProductsLoaded("search_results", items));
      } catch (e) {
        emit(ProductsFailure("search_results", e.toString()));
      }
    });
  }
}
