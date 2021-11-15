import 'package:ecommerce_app/screens/profileInfo.dart';
import 'package:ecommerce_app/widgets/user_profile/profile_header.dart';
import 'package:ecommerce_app/widgets/user_profile/profile_menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'Cart.dart';
import 'EditProfile.dart';
import 'Orders.dart';
import 'favourit_products.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            ProfileHeader(),
            SizedBox(
              height: 20,
            ),
            ProfileMenuItem(
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavouritProducts()));
              },
              label: 'My Favorite',
              borderColor: Colors.red,
              iconData: Icons.favorite_border_rounded,
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenuItem(
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              label: 'My Cart',
              borderColor: Colors.blue,
              iconData: Icons.shopping_cart,
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenuItem(
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profileInfo()));
              },
              label: ' Profile',
              borderColor: Colors.green,
              iconData: Icons.person,
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenuItem(
              ontap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Orders()));
              },
              label: 'My Orders',
              borderColor: Colors.deepPurple,
              iconData: Icons.border_all,
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenuItem(
              ontap: () {
                final String url = 'path';
                final RenderBox box = context.findRenderObject();
                Share.share(url,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
              label: 'Share App',
              borderColor: Colors.orange,
              iconData: Icons.share,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
