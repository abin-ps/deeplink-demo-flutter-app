import 'package:deeplink_demo_app/models/products.dart';
import 'package:deeplink_demo_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: ListView.builder(
          itemCount: productsList.length,
          itemBuilder: (context, index) => ProductTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      id: productsList[index].id.toString(),
                    ),
                  ));
            },
            productName: productsList[index].name,
            dateAdded: productsList[index].dateAdded,
            description: productsList[index].description,
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.productName,
    required this.dateAdded,
    required this.description,
    required this.onTap,
  });

  final String productName;
  final String dateAdded;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          Text(productName),
          const SizedBox(width: 4),
          Text(dateAdded),
        ],
      ),
      subtitle: Text(description),
    );
  }
}
