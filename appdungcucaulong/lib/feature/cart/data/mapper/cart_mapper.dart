import '../../domain/entity/cart_item_entity.dart';
import '../dto/respone/cart_item_response_dto.dart';

extension CartItemMapper on CartItemResponseDTO {
  CartItemEntity toEntity() => CartItemEntity(
        cartItemId: cartItemId,
        productId: productId,
        sizeId: sizeId,
        quantity: quantity,
        productName: name,
        image: image,
        price: price,
        sizeName: sizeName,
      );
}
