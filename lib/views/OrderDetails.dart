import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/order.dart';
import 'package:food_ordering_app/models/order.dart';

class OrderDetails extends StatelessWidget {
  final int? orderId;
  final double? totalPrice;

  OrderDetails({this.orderId, this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("OrderDetails"),
        ),
        body: FutureBuilder<List<OrderItem>>(
          future: OrderDatabaseHelper.getOrderItems(orderId ?? 0),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Order Items found.'));
            } else {
              List<OrderItem> orderItems = snapshot.data!;
              return Column(
                children: [
                  Card(
                      color: Colors.amber,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: orderItems.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Image.asset(
                                          orderItems[index].productImage,
                                          width: 40,
                                          height: 40),
                                      Text(orderItems[index].productName),
                                      Text('${orderItems[index].productPrice}')
                                    ],
                                  ));
                            }),
                      )),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    'Total: \$$totalPrice',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
