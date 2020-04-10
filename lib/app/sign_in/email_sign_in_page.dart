import 'package:advexam/app/sign_in/email_sigin_form_bloc_based.dart';
import 'package:flutter/material.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Sign In'),
          elevation: 2.0,
          backgroundColor: Colors.brown.withOpacity(0.1)),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/m5.jpg'), fit: BoxFit.fill)),
          child: Center(
            heightFactor: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.transparent,
                child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(1.0),
                        child: EmailSignInFormBlocBased.create(context))),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
