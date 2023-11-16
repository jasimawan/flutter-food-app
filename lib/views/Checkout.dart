import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/order.dart';
import 'package:food_ordering_app/provider/cartProvider.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              Card(
                  color: Colors.amber,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: cartProvider.cartList.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Image.asset(
                                      cartProvider.cartList[index].imageUrl,
                                      width: 40,
                                      height: 40),
                                  Text(cartProvider.cartList[index].name),
                                  Text('${cartProvider.cartList[index].price}')
                                ],
                              ));
                        }),
                  )),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Text(
                'Total: \$${cartProvider.totalPrice}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              ElevatedButton(
                onPressed: () async {
                  if (cartProvider.cartList.isEmpty) {
                    return;
                  }
                  await OrderDatabaseHelper.createOrder(
                      cartProvider.totalPrice, cartProvider.cartList);
                  cartProvider.emptyCart();
                  Navigator.of(context).pop();
                },
                child: const Text('Place Order'),
              )
            ],
          );
        },
      ),
    );
  }
}
