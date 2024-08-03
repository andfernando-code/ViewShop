import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/model/productModel.dart';

class ResultPage extends StatelessWidget {
  final List<Product> filteredProducts;

  const ResultPage({
    Key? key,
    required this.filteredProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: filteredProducts.isEmpty
          ? Center(
              child: Text(
                'No results found',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final Product product = filteredProducts[index];
                return ListTile(
                  title: Text(product.itemName),
                  // Add more details or customize ListTile as needed
                );
              },
            ),
    );
  }
}
