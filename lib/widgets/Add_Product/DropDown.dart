import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/providers/cutsom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var categories= Provider.of<List<category>>(context);
    var provider=Provider.of<Custom_Provider>(context);
    return DropdownButtonFormField(
      items: categories.map((cat) {
        return new DropdownMenuItem(
            value: cat.name,
            child: Row(
              children: <Widget>[
                Text(cat.name),
              ],
            )
        );
      }).toList(),
      onChanged: provider.chooseCategory,
      value: provider.CategoryValue,
      decoration: InputDecoration(
          enabledBorder:OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              )
          ),
          focusColor: Colors.blue,
          fillColor: Colors.red,
          labelText: 'Category',
          labelStyle: TextStyle(
              color: Colors.red,
              fontSize: 20
          )
      ),
    );
  }
}
