import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopnest/model/productModel.dart';
import 'package:shopnest/shop/storeWidget/categories.dart';
import 'package:shopnest/shop/storeWidget/homeSlider.dart';
import 'package:shopnest/shop/storeWidget/homeappbar.dart';
import 'package:shopnest/shop/storeWidget/productStoreCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSlider = 0;
  late User? user;
  late List<Product> products = [];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchProducts().then((List<Product> fetchedProducts) {
      setState(() {
        products = fetchedProducts;
      });
    }).catchError((error) {
      print('Error fetching products: $error');
    });
  }

  Future<List<Product>> fetchProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      List<Product> products = querySnapshot.docs.map((doc) {
        Map<String, dynamic>? data =
            doc.data() as Map<String, dynamic>? ?? {};
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
          category: category,
          colors: colors, 
          isFavorite: false, 
          reviewRate: reviewRate,
        );
      }).toList();
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                const SizedBox(height: 20),
                HomeSlider(
                  onChange: (value) {
                    setState(() {
                      currentSlider = value;
                    });
                  },
                  currentSlider: currentSlider,
                  imagePaths: [
                    'assets/slider/slide.jpg',
                    'assets/slider/slide2.jpg',
                    'assets/slider/slide1.jpg',
                  ],
                ),
                const SizedBox(height: 20),
                ShopNestCategories(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Special For You',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return ProductListCard(product: product);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
