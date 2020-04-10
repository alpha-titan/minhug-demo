import 'package:advexam/animation/animation.dart';
import 'package:advexam/app/sign_in/email_sign_in_page.dart';
import 'package:advexam/app/sign_in/sign_bloc.dart';
import 'package:advexam/app/sign_in/sign_in_button.dart';
import 'package:advexam/app/sign_in/social_sign_in_button.dart';
import 'package:advexam/common_widgets/platform_alert_dialogue.dart';
import 'package:advexam/common_widgets/platform_exception_alert_dialog.dart';
import 'package:advexam/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (context,bloc)=>bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, _) => SignInPage(
          bloc: bloc,
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in Failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _confirmSignIn(BuildContext context) async {
    final didRequestSignIn = await PlatformAlertDialog(
      title: 'Logot',
      content: ' Are you sure you want to sign in with google?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Continue',
    ).show(context);
    if (didRequestSignIn == true) {
      _signInWithGoogle(context);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {

      await bloc.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true, builder: (context) => EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignInBloc>(context);
    return Scaffold(
      appBar: AppBar(
          title: FadeAnimation(1,Text('Mind Hug',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 25,
            color: Colors.green[300]

          ),),),
          elevation: 2.0,
          backgroundColor: Colors.black.withOpacity(0.89)),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/m1.jpg'), fit: BoxFit.fill)),
      child: Center(
        heightFactor: MediaQuery.of(context).size.height - 125,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeader(isLoading),
              SizedBox(
                height: 48.0,
              ),
              SizedBox(
                height: 8.0,
              ),
          FadeAnimation(1.2,SocialSignInButton(
                assetName: 'images/google-logo.png',
                text: 'Sign in with Google',
                textColor: Colors.green[300],
                onPressed: isLoading ? null : () => _confirmSignIn(context),
                color: Colors.transparent,
              ),),
              SizedBox(
                height: 8.0,
              ),
          FadeAnimation(1.4,SigInButton(
                text: 'Sign in with Email',
                textColor: Colors.white,
                onPressed: isLoading ? null : () => _signInWithEmail(context),
                color: Colors.teal[300].withOpacity(0.5),
              ),),
              SizedBox(
                height: 8.0,
              ),
          FadeAnimation(1.6,Text(
                'or',
                style: TextStyle(fontSize: 14.0, color: Colors.white,fontFamily: 'Pacifico'),
                textAlign: TextAlign.center,
              ),),
              SizedBox(
                height: 8.0,
              ),
              FadeAnimation(1.8,SigInButton(
                text: 'Go Anonymous',
                textColor: Colors.black,
                onPressed: isLoading ? null : () => _signInAnonymously(context),
                color: Colors.lime[300].withOpacity(0.5),
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      );
    }
    return FadeAnimation(1.2,Text(
      'Sign In',
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
        color: Colors.green[200],
        fontFamily: 'Pacifico',
      ),
    ));
  }
}
