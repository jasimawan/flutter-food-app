class Product {
  int id;
  int categoryId;
  String name;
  double price;
  String imageUrl;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      imageUrl: map['image_url'],
      name: map['name'],
      categoryId: map['category_id'],
      price: map['price'],
    );
  }
}
