import 'package:flutter/material.dart';

class customRaisedButton extends StatelessWidget {
  customRaisedButton(
      {this.child,
      this.borderRadius: 2.0,
      this.color,
      this.onPressed,
      this.height: 50.0}) : assert(borderRadius!=null);

  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        elevation: 10.0,
        disabledColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: child,
        onPressed: onPressed,
        color: color,
      ),
    );
  }
}
