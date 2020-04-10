import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:advexam/services/auth.dart';
import 'package:flutter/cupertino.dart';

class SignInBloc {
  SignInBloc({@required this.auth});
  final AuthBase auth;

  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose()
  {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading)=> _isLoadingController.add(isLoading);


  Future<User> _signIn(Future<User> Function() signInMethod) async{
    try{
      _setIsLoading(true);
      return await signInMethod();
    }catch(e){
      _setIsLoading(false);
      rethrow;
    }

  }


  Future<User> signInAnonymously() async => await _signIn(auth.signInAnonymously);


  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

}