import 'package:ecommerce_app/screens/Cart.dart';
import 'package:ecommerce_app/screens/add_product.dart';
import 'package:ecommerce_app/screens/favourit_products.dart';
import 'package:ecommerce_app/screens/user_home.dart';
import 'package:ecommerce_app/screens/user_profile.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPages extends StatefulWidget {
  @override
  _UserPagesState createState() => _UserPagesState();
}

class _UserPagesState extends State<UserPages> {
  PageController _controller = PageController();
  List<Widget> _screens=[
    user_home(),
    AddProduct(),
    FavouritProducts(),
    UserProfile(),
  ];
  int selectedindex=0;

  void _itemTaped(int selectedindex){
    _controller.jumpToPage(selectedindex);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _screens,
        physics: NeverScrollableScrollPhysics(),
      ),

      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: Colors.grey[50],
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.add, title: "Add"),
          TabData(iconData: Icons.favorite, title: "favorite"),
          TabData(iconData: Icons.person, title: "profile")
        ],
        onTabChangedListener: _itemTaped
      ),

    );
  }
}
