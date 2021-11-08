import 'package:flutter/material.dart';
import 'package:o_color_picker/o_color_picker.dart';

class ColorBickerDynamic extends StatefulWidget {
  Color colorvalue = Color(0xfff44336);
  @override
  _ColorBickerDynamicState createState() => _ColorBickerDynamicState();
}

class _ColorBickerDynamicState extends State<ColorBickerDynamic> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: new GestureDetector(
          child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(color: widget.colorvalue, boxShadow: [
                BoxShadow(blurRadius: 1, color: Colors.black, spreadRadius: .1)
              ])),
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (_) => Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OColorPicker(
                      selectedColor: widget.colorvalue,
                      colors: primaryColorsPalette,
                      onColorChange: (color) {
                        setState(() {
                          widget.colorvalue = color;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
