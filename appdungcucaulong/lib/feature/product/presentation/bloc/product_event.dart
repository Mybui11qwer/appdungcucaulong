abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}

class GetProductDetailEvent extends ProductEvent {
  final int id;

  GetProductDetailEvent(this.id);
}