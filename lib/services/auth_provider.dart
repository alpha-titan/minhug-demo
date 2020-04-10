import 'package:advexam/services/auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends InheritedWidget{
  AuthProvider({this.auth, @required this.child});
  final AuthBase auth;
  final Widget child;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  //final auth = AuthProvider.of(context);
static AuthBase of(BuildContext context){
  AuthProvider provider =context.dependOnInheritedWidgetOfExactType();
  return provider.auth;

}

}