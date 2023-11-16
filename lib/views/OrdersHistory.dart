import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/order.dart';
import 'package:food_ordering_app/models/order.dart';
import 'package:food_ordering_app/views/OrderDetails.dart';
import 'package:food_ordering_app/widgets/CartFloatingButton.dart';

class OrdersHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders History'),
      ),
      floatingActionButton: const CartFloatingButton(),
      body: FutureBuilder<List<Order>>(
        future: OrderDatabaseHelper.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Orders found.'));
          } else {
            List<Order> orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetails(
                          orderId: orders[index].id,
                          totalPrice: orders[index].totalAmount,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Order id: ${orders[index].id}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Amount: ${orders[index].totalAmount}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Date: ${orders[index].dateTime}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
