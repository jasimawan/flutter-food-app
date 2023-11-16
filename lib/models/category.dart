class Category {
  int id;
  String name;
  String image;

  Category({required this.id, required this.name, required this.image});

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(id: map['id'], name: map['name'], image: map['image']);
  }
}
