import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  late final String text;
  late final Color colour;
  late final VoidCallback onPressed;

  RoundButton(this.text, this.colour, this.onPressed) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
