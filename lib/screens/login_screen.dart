import 'package:flash_chat/components/round_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(controller!.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
                decoration: kDecoration.copyWith(hintText: 'Enter your email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
                decoration: kDecoration.copyWith(hintText: 'Enter Password')),
            SizedBox(
              height: 24.0,
            ),
            RoundButton('Log In', Colors.lightBlueAccent, () {})
          ],
        ),
      ),
    );
  }
}
