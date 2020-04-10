import 'package:advexam/app/landing_page.dart';
import 'package:advexam/services/auth.dart';
import 'package:advexam/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
     create: (context)=>Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,

        ),
        home: LandingPage(
        ),
      ),
    );
  }
}
