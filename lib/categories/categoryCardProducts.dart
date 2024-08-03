import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopnest/categories/categoryList.dart';
import 'package:shopnest/model/productModel.dart';
import 'package:shopnest/shop/pages/main_screen.dart';
import 'package:shopnest/shop/storeWidget/productStoreCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopnest/widgets/loader.dart';

class CategoryCardProducts extends StatefulWidget {
  final String categoryName;
  const CategoryCardProducts({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<CategoryCardProducts> createState() => _CategoryCardProductsState();
}

class _CategoryCardProductsState extends State<CategoryCardProducts> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: widget.categoryName) 
          .get();
      List<Product> products = querySnapshot.docs.map((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          throw Exception('Document data is null');
        }

        String itemID = doc.id;
        String itemName = data['itemName'].toString();
        String description = data['description'].toString();
        String image = data['image'].toString();
        double price = (data['price'] ?? 0).toDouble();
        String colors = data['color'];
        String category = data['category'] ?? '';
        double reviewRate = (data['reviewRate'] ?? 0).toDouble();

        return Product(
          itemID: itemID,
          itemName: itemName,
          description: description,
          image: image,
          price: price,
          colors: colors,
          category: category,
          reviewRate: reviewRate,
          isFavorite: true,
        );
      }).toList();
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Ionicons.chevron_back,size: 45,),
          onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainBottom()));
          },
          ),
       
        title: CategoryProductList(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShopNestLoader();
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Product> product = snapshot.data ?? [];
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    final productItem = product[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 2),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ProductListCard(product: productItem),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
