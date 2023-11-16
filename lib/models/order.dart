class Order {
  int id;
  List<OrderItem> items;
  double totalAmount;
  DateTime dateTime;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        id: map['id'],
        items: map['items'],
        totalAmount: map['total_amount'],
        dateTime: map['order_date']);
  }
}

class OrderItem {
  int productId;
  int orderId;
  String productName;
  double productPrice;
  int quantity;

  OrderItem({
    required this.productId,
    required this.orderId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
        productId: map['productId'],
        orderId: map['orderId'],
        productName: map['productName'],
        productPrice: map['productPrice'],
        quantity: map['quantity']);
  }
}
