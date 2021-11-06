import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatelessWidget {
  final productlist;

  ProductList({this.productlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: productlist?.length ?? 0,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){

            },
            child: Container(
                width: MediaQuery.of(context).size.width-40,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 5)
                    ]
                ),
                height: 200,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(productlist[index].image,fit: BoxFit.cover,),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2-40,
                      padding: EdgeInsets.only(left: 20,top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sony s10 Headphones',style: GoogleFonts.actor(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )
                          ),),
                          SizedBox(height: 5,),
                          Text('200 \$',style: GoogleFonts.actor(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red
                              )
                          ),),
                          SizedBox(height: 5,),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text('Technology')
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.shopping_cart,color: Colors.white,)
                              ),
                              SizedBox(width: 5,),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.favorite,color: Colors.white,)
                              ),
                            ],
                          )

                        ],
                      ),
                    )
                  ],
                )
            ),
          );
        },
      ),
    );
  }
}
