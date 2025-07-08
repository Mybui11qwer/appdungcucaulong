class CartItemResponseDTO {
  final int id;
  final int productId;
  final int sizeId;
  final int quantity;
  final String name;
  final String image;
  final double price;
  final String sizeName;

  CartItemResponseDTO({
    required this.id,
    required this.productId,
    required this.sizeId,
    required this.quantity,
    required this.name,
    required this.image,
    required this.price,
    required this.sizeName,
  });

  factory CartItemResponseDTO.fromJson(Map<String, dynamic> json) =>
      CartItemResponseDTO(
        id: json['ID_CartItem'],
        productId: json['ID_Product'],
        sizeId: json['ID_Size'],
        quantity: json['Quantity'],
        name: json['Name'],
        image: json['Image'],
        price: (json['Price'] as num).toDouble(),
        sizeName: json['SizeName'],
      );
}
