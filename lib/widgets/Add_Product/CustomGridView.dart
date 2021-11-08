import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final List list;
  final int Axiscount;

  const CustomGridView({this.list,this.Axiscount});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,top: 10),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Axiscount,
          ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (_,index)=>list[index]
      ),
    );
  }
}
