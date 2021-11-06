import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authprovider= Provider.of<auth_provider>(context);
    return Container(
      width: double.infinity,
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.exit_to_app,size: 30,color: Colors.white,)
                  ],
                ),
              ),
              SizedBox(height: 35,),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black,blurRadius: 5,spreadRadius: .1)
                    ],
                    borderRadius: BorderRadius.circular(50)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(authprovider.userdata.photoURL),
                ),
              ),
              SizedBox(height: 10,),
              Text(authprovider.userdata.displayName,style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),)
            ],
          )
        ],
      ),
    );
  }
}
