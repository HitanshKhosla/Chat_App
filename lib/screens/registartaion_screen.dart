import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/round_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;

  String? email;
  String? password;
  AnimationController? controller;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          backgroundColor: Colors.grey,
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: "logo",
                      child: Container(
                        height: controller!.value * 150.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration:
                            kDecoration.copyWith(hintText: "Enter Your email")),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration:
                            kDecoration.copyWith(hintText: 'Enter password')),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundButton('Register', Colors.blueAccent, () async {
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email.toString(),
                                password: password.toString());

                        Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                      ;
                    })
                  ]))),
    );
  }
}
