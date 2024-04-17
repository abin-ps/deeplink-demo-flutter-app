import 'package:deeplink_demo_app/models/products.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final Product _selectedProduct;

  getProductDetails() {
    _selectedProduct = productsList.firstWhere(
      (element) => element.id.toString() == widget.id,
      orElse: () => Product(id: -1, name: 'Product not found!', description: 'Please verify the product id.', dateAdded: ''),
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: ProductCard(
          productName: _selectedProduct.name,
          dateAdded: _selectedProduct.dateAdded,
          description: _selectedProduct.description,
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productName,
    required this.dateAdded,
    required this.description,
  });
  final String productName;
  final String dateAdded;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(productName),
            const SizedBox(height: 16),
            Text(dateAdded),
            const SizedBox(height: 16),
            Text(description),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
