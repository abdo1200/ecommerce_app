import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:ecommerce_app/screens/Cart.dart';
import 'package:ecommerce_app/screens/add_product.dart';
import 'package:ecommerce_app/screens/favourit_products.dart';
import 'package:ecommerce_app/screens/user_home.dart';
import 'package:ecommerce_app/screens/user_profile.dart';
import 'package:ecommerce_app/widgets/FloatingButton.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserPages extends StatefulWidget {
  @override
  _UserPagesState createState() => _UserPagesState();
}

class _UserPagesState extends State<UserPages> {
  User user = FirebaseAuth.instance.currentUser;
  PageController _controller = PageController();
  List<Widget> _screens = [
    user_home(),
    AddProduct(),
    FavouritProducts(),
    UserProfile(),
  ];

  int selectedindex = 0;
  void _itemTaped(index) {
    _controller.jumpToPage(index);
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<auth_provider>(context);
    List<Widget> appBar = [
      AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    user.photoURL,
                    width: 40,
                  )),
              SizedBox(
                width: 10,
              ),
              Text(
                'Hi, ${user.displayName}',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Provider.of<auth_provider>(context, listen: false)
                          .Logout_method(context);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    )),
              ],
            ),
          )
        ],
      ),
      AppBar(
        title: Text('Add Product'),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => authprovider.Logout_method(context))
        ],
      ),
      AppBar(
        title: Text('My Favorite'),
      ),
      null,
    ];
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBar[selectedindex],
      body: PageView(
        controller: _controller,
        children: _screens,
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: FloatingButton(),
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 100.0)),
      bottomNavigationBar: FancyBottomNavigation(
          barBackgroundColor: Colors.grey[50],
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.add, title: "Add"),
            TabData(iconData: Icons.favorite, title: "favorite"),
            TabData(iconData: Icons.person, title: "profile")
          ],
          onTabChangedListener: _itemTaped),
    );
  }
}
