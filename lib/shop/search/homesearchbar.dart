import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopnest/model/productModel.dart';

class HomeSearchBar extends StatelessWidget {
  final List<Product> allProducts;
  final Function(List<Product>) onSearch;

  const HomeSearchBar({
    Key? key,
    required this.allProducts,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            const Icon(
              Ionicons.search,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 4,
              child: TextField(
                onChanged: (query) {
                 
                  final List<Product> filteredProducts = allProducts
                      .where((product) =>
                          product.itemName.toLowerCase().contains(query.toLowerCase()))
                      .toList();
              
                  onSearch(filteredProducts);
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: 1.5,
              height: 25,
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Ionicons.options_outline,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
