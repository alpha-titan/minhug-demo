import 'package:flutter/material.dart';

import 'custom_raised_button.dart';


class FormSubmitButton extends customRaisedButton {
  FormSubmitButton({
    @required String text,
   VoidCallback onPressed,
}): super(
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white, fontSize: 20.0,
      ),
    ),
        height:44.0,
    color:Colors.green.withOpacity(0.5),
    borderRadius:10.0,
    onPressed:onPressed,

  );
}