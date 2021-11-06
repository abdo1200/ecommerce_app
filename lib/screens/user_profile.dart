import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/widgets/profile_header.dart';
import 'package:ecommerce_app/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authprovider= Provider.of<auth_provider>(context);
    return Scaffold(
      body: Column(
        children: [
          ProfileHeader(),
          SizedBox(height: 20,),
          ProfileMenuItem(
            ontap: (){},
            label: 'My Favorite',
            borderColor: Colors.red,
            iconData: Icons.favorite_border_rounded,
          ),
          SizedBox(height: 10,),
          ProfileMenuItem(
            ontap: (){},
            label: 'My Cart',
            borderColor: Colors.blue,
            iconData: Icons.shopping_cart,
          ),
          SizedBox(height: 10,),
          ProfileMenuItem(
            ontap: (){},
            label: 'Edit Profile',
            borderColor: Colors.green,
            iconData: Icons.edit,
          ),
          SizedBox(height: 10,),
          ProfileMenuItem(
            ontap: (){},
            label: 'My Orders',
            borderColor: Colors.deepPurple,
            iconData: Icons.border_all,
          ),
          SizedBox(height: 10,),
          ProfileMenuItem(
            ontap: (){},
            label: 'Share App',
            borderColor: Colors.orange,
            iconData: Icons.share,
          ),
        ],
      ),
    );
  }
}
