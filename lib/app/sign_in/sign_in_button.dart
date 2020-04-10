import 'package:advexam/common_widgets/custom_raised_button.dart';
import 'package:flutter/cupertino.dart';

class SigInButton extends customRaisedButton {
  SigInButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 18.0, fontFamily: 'Pacifico', letterSpacing: 1.0),
          ),
          color: color,
          onPressed: onPressed,
          borderRadius: 8.0,
        );
}
