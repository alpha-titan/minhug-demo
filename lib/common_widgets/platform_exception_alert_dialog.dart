

import 'package:advexam/common_widgets/platform_alert_dialogue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {@required String title,
        @required PlatformException exception}):super(
    title:title,
    content: _message(exception),
    defaultActionText: 'OK'
  );
  static String _message(PlatformException exception){
    if(exception.message == 'PERMISSION_DENIED: Missing or insufficient permissions.')
      if(exception.code =='Error performing setData' )
        return 'Missing or Insufficient Permission';
    return _errors[exception.code]??exception.message;
  }
  static Map<String, String> _errors = {
    'ERROR_INVALID_EMAIL' : 'The Email is Invalid',
    'ERROR_WRONG_PASSWORD' : ' The password is invalid.',
    'ERROR_USER_NOT_FOUND': 'The user corresponding to this email doe not exist',
    ///  * `ERROR_WEAK_PASSWORD` - If the password is not strong enough.

    ///  * `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.


    ///  * `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
    ///  * `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
    ///  * `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.

  };
}

