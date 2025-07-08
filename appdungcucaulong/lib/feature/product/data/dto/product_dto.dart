import '../../domain/entity/product_entity.dart';

class ProductDTO {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String image;

  ProductDTO({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.image,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      id: json['ID_Product'],
      name: json['Name'],
      price: (json['Price'] as num).toDouble(),
      quantity: json['Quantity'],
      description: json['Description'],
      image: json['Image'],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      price: price,
      quantity: quantity,
      description: description,
      image: image,
    );
  }
}
