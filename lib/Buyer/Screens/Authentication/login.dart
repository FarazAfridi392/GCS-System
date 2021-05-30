import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Buyer/Screens/Authentication/register.dart';

import 'package:e_shop/Buyer/Widgets/customTextField.dart';
import 'package:e_shop/Buyer/DialogBox/errorDialog.dart';
import 'package:e_shop/Buyer/DialogBox/loadingDialog.dart';
import 'package:e_shop/Buyer/Screens/intro_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_shop/config.dart';

import '../../../app_properties.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  FirebaseUser firebaseUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(
      context: context,
      builder: (_) {
        return LoadingAlertDialog(
          message: "Authenticating Please Wait",
        );
      },
    );
    await _auth
        .signInWithEmailAndPassword(
            email: _email.text.trim(), password: _pass.text.trim())
        .then((fuser) {
      firebaseUser = fuser.user;
    }).catchError(
      (error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (_) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          },
        );
      },
    );
    if (firebaseUser != null) {
      readData(firebaseUser).then(
        (value) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) {
                return IntroScreen();
              },
            ),
          );
        },
      );
    }
  }

  Future readData(FirebaseUser fUser) async {
    Firestore.instance.collection('buyers').document(fUser.uid).get().then(
      (dataSnapshot) async {
        await EcommerceApp.sharedPreferences.setString(
            EcommerceApp.userUID, dataSnapshot.data[EcommerceApp.userUID]);
        await EcommerceApp.sharedPreferences.setString(
            EcommerceApp.userEmail, dataSnapshot.data[EcommerceApp.userEmail]);
        await EcommerceApp.sharedPreferences.setString(
            EcommerceApp.userName, dataSnapshot.data[EcommerceApp.userName]);
        await EcommerceApp.sharedPreferences.setString(
            EcommerceApp.userAvatarUrl,
            dataSnapshot.data[EcommerceApp.userAvatarUrl]);

        await EcommerceApp.sharedPreferences.setBool(EcommerceApp.boolSeller,
            dataSnapshot.data[EcommerceApp.boolSeller]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget userType = Row();
    Widget welcomeBack = Text(
      'Welcome Back',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Login to your account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget loginButton = InkWell(
      onTap: () {
        _email.text.isNotEmpty && _pass.text.isNotEmpty
            ? loginUser()
            : showDialog(
                context: context,
                builder: (_) {
                  return ErrorAlertDialog(
                    message: "Please type e-mail and password",
                  );
                },
              );
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        child: Center(
            child: new Text("Log In",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0))),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(236, 60, 3, 1),
                  Color.fromRGBO(234, 60, 3, 1),
                  Color.fromRGBO(216, 78, 16, 1),
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
      ),
    );

    Widget socialRegister = Column(
      children: <Widget>[
        Text(
          'You can sign in with',
          style: TextStyle(
              fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Image.asset("assets/google.png"),
              onPressed: () {},
              color: Colors.white,
            ),
            IconButton(
                icon: Image.asset("assets/facebook.png"),
                onPressed: () {},
                color: Colors.white),
          ],
        )
      ],
    );

    Widget loginForm = Container(
      height: 280,
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 28.0),
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.only(left: 32.0, right: 12.0, bottom: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        decoration: InputDecoration(hintText: "Email"),
                        controller: _email,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        decoration: InputDecoration(hintText: "Password"),
                        controller: _pass,
                        style: TextStyle(fontSize: 16.0),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 23),
            child: loginButton,
          ),
        ],
      ),
    );

    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Forgot your password? ',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color.fromRGBO(255, 255, 255, 0.5),
                fontSize: 14.0,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Reset password',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Widget signIn = GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Register()));
      },
      child: Text.rich(
        TextSpan(
          text: "Don't have an account? ",
          children: [
            TextSpan(
              text: "Sign up",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue.shade700),
            ),
          ],
        ),
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );

    return Scaffold(
      body: Container(
          height: double.infinity,
          color: kYellow,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 28.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  welcomeBack,
                  SizedBox(
                    height: 30,
                  ),
                  subTitle,
                  SizedBox(
                    height: 30,
                  ),
                  loginForm,
                  SizedBox(
                    height: 10,
                  ),
                  forgotPassword,
                  SizedBox(
                    height: 2,
                  ),
                  Center(child: signIn),
                  SizedBox(
                    height: 60,
                  ),
                  socialRegister
                ],
              ),
            ),
          )),
    );
    // double _screenWidth = MediaQuery.of(context).size.width,
    //     _screenHeight = MediaQuery.of(context).size.height;
    // return SingleChildScrollView(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       Container(
    //         alignment: Alignment.bottomCenter,
    //         child: Image.asset("images/login.png"),
    //         height: 240,
    //         width: 240,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: Text(
    //           "Login to your Account",
    //           style: TextStyle(
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //       Form(
    //         key: _formkey,
    //         child: Column(
    //           children: [
    //             CustomTextField(
    //               data: Icons.email,
    //               isObsecure: false,
    //               controller: _email,
    //               hintText: "E-mail",
    //             ),
    //             CustomTextField(
    //               data: Icons.person,
    //               isObsecure: true,
    //               controller: _pass,
    //               hintText: "Password",
    //             ),
    //           ],
    //         ),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    // _email.text.isNotEmpty && _pass.text.isNotEmpty
    //     ? loginUser()
    //     : showDialog(
    //         context: context,
    //         builder: (_) {
    //           return ErrorAlertDialog(
    //             message: "Please type e-mail and password",
    //           );
    //         },
    //       );
    //         },
    //         style: ButtonStyle(
    //           backgroundColor: MaterialStateProperty.all(Colors.pink),
    //         ),
    //         child: Text(
    //           'Sign In',
    //           style: TextStyle(
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //       SizedBox(
    //         height: 50,
    //       ),
    //       Container(
    //         width: _screenWidth * 0.8,
    //         height: 4.0,
    //         color: Colors.pink,
    //       ),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       TextButton.icon(
    //         onPressed: () {
    //           Navigator.pushReplacement(context,
    //               MaterialPageRoute(builder: (_) => AdminSignInPage()));
    //         },
    //         icon: Icon(
    //           Icons.nature_people,
    //           color: Colors.pink,
    //         ),
    //         label: Text(
    //           "I'm admin",
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
