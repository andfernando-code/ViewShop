import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopnest/shop/cart/cartPage.dart';
import 'package:shopnest/shop/pages/home.dart';
import 'package:shopnest/shop/pages/store.dart';
import 'package:shopnest/user/user_profile.dart';

class MainBottom extends StatefulWidget {
  const MainBottom({super.key});

  @override
  State<MainBottom> createState() => _MainBottomState();
}

class _MainBottomState extends State<MainBottom> {


  int currentTab =0;
  List screens = [
    HomePage(),
    ShopNestStore(),
    CartPage(),
    UserProfilePage(),

  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomBar start
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: Colors.black,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max ,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: ()=>setState(() {
                currentTab=0;
              }), 
              color: Colors.white,
              icon :currentTab == 0 ? Icon(Ionicons.home) :  Icon(Ionicons.home_outline)
              ),

            IconButton(
              onPressed: ()=>setState(() {
                currentTab=1;
              }), 
              color: Colors.white,
              icon: currentTab == 1 ? Icon(Ionicons.storefront) : Icon(Ionicons.storefront_outline),
              ),

            IconButton(
              onPressed: ()=>setState(() {
                currentTab=2;
              }), 
              color: Colors.white,
              icon : currentTab == 2 ? Icon(Ionicons.cart) :  Icon(Ionicons.cart_outline)
              ),

            IconButton(
              onPressed: ()=>setState(() {
                currentTab=3;
              }), 
              color: Colors.white,
              icon: currentTab == 3 ? Icon(Ionicons.person) :  Icon(Ionicons.person_outline)
              ),
          ],
        ),
      ),
      //bottomBar end

    body: screens[currentTab],
    );

    
  }
}