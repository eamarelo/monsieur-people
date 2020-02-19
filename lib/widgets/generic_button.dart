import 'package:flutter/material.dart';

class GenericButtonWidget extends StatefulWidget {
  final String title;
  final Function buttonPressed;

  GenericButtonWidget(this.title, this.buttonPressed);

  @override
  _GenericButtonWidgetState createState() => _GenericButtonWidgetState();
}

class _GenericButtonWidgetState extends State<GenericButtonWidget> {
  Color _color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _color = Color.fromRGBO(17, 121, 134, 1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        setState(() {
          _color = Colors.red;
        });
      },
      onTapCancel: () {
        setState(() {
          _color = Colors.blue;
        });
      },
      onTapUp: (detail) {
        widget.buttonPressed();
        setState(() {
          _color = Colors.blue;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: _color, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Center(
              child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
