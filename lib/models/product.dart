import 'package:ecommerce_app/models/category.dart';

class Product {
  final String name;
  final String image;
  final String description;
  final bool homeshowed;
  final colors;
  final sizes;
  final String price;
  final bool isTopSales;
  final String category;

  Product(
      {this.name,
      this.image,
      this.price,
      this.isTopSales,
      this.category,
      this.description,
      this.sizes,
      this.colors,
      this.homeshowed});

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      image: data['image'] ?? '',
      isTopSales: data['isTopSale'] ?? '',
      price: data['price'] ?? '',
      sizes: data['sizes'] ?? '',
      colors: data['colors'] ?? '',
      description: data['description'] ?? '',
      homeshowed: data['homeSale'] ?? '',
    );
  }
}
