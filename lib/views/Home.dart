import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/menu.dart';
import 'package:food_ordering_app/models/category.dart';
import 'package:food_ordering_app/views/OrdersHistory.dart';
import 'package:food_ordering_app/views/Products.dart';
import 'package:food_ordering_app/widgets/CartFloatingButton.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersHistory(),
                ),
              );
            },
            child: const Text('Orders History'),
          ),
          const Padding(padding: EdgeInsets.only(right: 10))
        ],
      ),
      floatingActionButton: const CartFloatingButton(),
      body: FutureBuilder<List<Category>>(
        future: MenuDatabaseHelper.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories found.'));
          } else {
            List<Category> categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Products(
                          categoryId: categories[index].id,
                          categoryName: categories[index].name,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(categories[index].image),
                        ListTile(
                          title: Text(
                            categories[index].name,
                            style: const TextStyle(fontSize: 30),
                          ),
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
