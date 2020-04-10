import 'package:advexam/common_widgets/custom_raised_button.dart';
import 'package:flutter/cupertino.dart';

class SocialSignInButton extends customRaisedButton {
  SocialSignInButton(
      {@required String text,
      Color color,
      Color textColor,
      VoidCallback onPressed,
      @required String assetName})
      : assert(text != null),
        assert(assetName != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontFamily: 'Pacifico'
                ),
              ),
              Opacity(opacity: 0.0, child: Image.asset(assetName))
            ],
          ),
          color: color,
          onPressed: onPressed,
          borderRadius: 8.0,
        );
}
