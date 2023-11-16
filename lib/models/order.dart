class Order {
  int id;
  double totalAmount;
  DateTime dateTime;

  Order({
    required this.id,
    required this.totalAmount,
    required this.dateTime,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        id: map['id'],
        totalAmount: map['total_amount'],
        dateTime: map['order_date']);
  }
}

class OrderItem {
  int id;
  int productId;
  int orderId;
  String productName;
  String productImage;
  double productPrice;
  int quantity;

  OrderItem(
      {required this.id,
      required this.productId,
      required this.orderId,
      required this.productName,
      required this.productPrice,
      required this.quantity,
      required this.productImage});

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
        id: map['id'],
        productId: map['productId'],
        orderId: map['orderId'],
        productName: map['productName'],
        productPrice: map['productPrice'],
        quantity: map['quantity'],
        productImage: map['product_image']);
  }
}
