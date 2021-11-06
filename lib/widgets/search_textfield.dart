import 'package:flutter/material.dart';

class search_textfield extends StatelessWidget {
  final String hinttext;
  final Color backcolor;
  final IconData iconData;
  final TextEditingController textEditingController;

  const search_textfield({this.hinttext, this.backcolor, this.iconData,this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: backcolor,
            borderRadius: BorderRadiusDirectional.circular(100)
        ),
        child: TextFormField(
          controller: textEditingController,
            decoration: InputDecoration(
              hintText: hinttext,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20.0),
              suffixIcon: (iconData!=null)?IconButton(
                onPressed: (){},
                icon: Icon(Icons.search,color: Colors.red,),
              ):null,
            )
        )
    );
  }
}
