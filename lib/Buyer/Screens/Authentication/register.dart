import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Buyer/Screens/Authentication/login.dart';
import 'package:e_shop/Buyer/Widgets/customTextField.dart';
import 'package:e_shop/Buyer/DialogBox/errorDialog.dart';
import 'package:e_shop/Buyer/DialogBox/loadingDialog.dart';
import 'package:e_shop/Buyer/Screens/intro_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_shop/config.dart';

import '../../../app_properties.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _imageUrl = '';
  File _imageFile;

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadandSaveImage() async {
    if (_imageFile == null) {
      showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: "Please select the image file",
          );
        },
      );
    } else {
      _pass.text == _confirmPass.text
          ? _name.text.isNotEmpty &&
                  _email.text.isNotEmpty &&
                  _pass.text.isNotEmpty &&
                  _confirmPass.text.isNotEmpty
              ? uploadToStorage()
              : displayDialogue("Please Fill up the complete registration form")
          : displayDialogue('Passwords do not match');
    }
  }

  displayDialogue(String mes) {
    showDialog(
      context: context,
      builder: (_) {
        return ErrorAlertDialog(
          message: mes,
        );
      },
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser() async {
    FirebaseUser firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
            email: _email.text.trim(), password: _pass.text.trim())
        .then((auth) {
      firebaseUser = auth.user;
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
      saveUserInfoToFirestore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (_) => IntroScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFirestore(FirebaseUser fUser) async {
    Firestore.instance.collection("buyers").document(fUser.uid).setData(
      {
        "uid": fUser.uid,
        "email": fUser.email,
        "name": _name.text.trim(),
        "url": _imageUrl,
        EcommerceApp.boolSeller: false,
        EcommerceApp.userCartList: [
          "garbageValue",
        ],
      },
    );

    await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, _name.text);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, _imageUrl);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
    await EcommerceApp.sharedPreferences
        .setBool(EcommerceApp.boolSeller, false);
  }

  uploadToStorage() async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog();
      },
    );

    String _imageFilename = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(_imageFilename);

    StorageUploadTask storageTask = storageReference.putFile(_imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await storageTask.onComplete;
    await storageTaskSnapshot.ref.getDownloadURL().then(
      (imageUrl) {
        _imageUrl = imageUrl;
        _registerUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    Widget title = Text(
      'Glad To Meet You',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget registerButton = InkWell(
      onTap: () {
        uploadandSaveImage();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 50,
        child: Center(
            child: new Text("Register",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0))),
        decoration: BoxDecoration(
            gradient: mainButton,
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

    Widget registerForm = SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 28),
              padding:
                  const EdgeInsets.only(left: 32.0, right: 12.0, bottom: 20),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        decoration: InputDecoration(hintText: "Name"),
                        controller: _name,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        decoration: InputDecoration(hintText: "E-Mail"),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextField(
                        decoration:
                            InputDecoration(hintText: "Confirm Password"),
                        controller: _confirmPass,
                        style: TextStyle(fontSize: 16.0),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Widget imageAvatar = InkWell(
      onTap: _selectAndPickImage,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CircleAvatar(
            radius: _screenWidth * 0.15,
            backgroundColor: Colors.white,
            backgroundImage: _imageFile == null ? null : FileImage(_imageFile),
            child: _imageFile == null
                ? Icon(
                    Icons.add_photo_alternate,
                    size: _screenWidth * 0.15,
                    color: Colors.grey,
                  )
                : null),
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

    Widget signUp = GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Login()));
      },
      child: Text.rich(
        TextSpan(
          text: "Already have an account? ",
          children: [
            TextSpan(
              text: "Sign in",
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
        height: MediaQuery.of(context).size.height,
        color: kYellow,
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Image.asset("assets/dissmis.png")),
                    ),
                  ),
                ),
                title,
                SizedBox(
                  height: 30,
                ),
                subTitle,
                SizedBox(
                  height: 30,
                ),
                Center(child: imageAvatar),
                SizedBox(
                  height: 30,
                ),
                registerForm,
                SizedBox(
                  height: 30,
                ),
                Center(child: registerButton),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                    padding: EdgeInsets.only(right: 25), child: socialRegister)
              ],
            ),
          ),
        ),
      ),
    );
    // double _screenWidth = MediaQuery.of(context).size.width,
    //     _screenHeight = MediaQuery.of(context).size.height;
    // return SingleChildScrollView(
    //   child: Container(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         SizedBox(
    //           height: 10.0,
    //         ),
    // InkWell(
    //   onTap: _selectAndPickImage,
    //   child: CircleAvatar(
    //       radius: _screenWidth * 0.15,
    //       backgroundColor: Colors.white,
    //       backgroundImage:
    //           _imageFile == null ? null : FileImage(_imageFile),
    //       child: _imageFile == null
    //           ? Icon(
    //               Icons.add_photo_alternate,
    //               size: _screenWidth * 0.15,
    //               color: Colors.grey,
    //             )
    //           : null),
    // ),
    //         Form(
    //           key: _formkey,
    //           child: Column(
    //             children: [
    //               CustomTextField(
    //                 data: Icons.person,
    //                 isObsecure: false,
    //                 controller: _name,
    //                 hintText: "Name",
    //               ),
    //               CustomTextField(
    //                 data: Icons.email,
    //                 isObsecure: false,
    //                 controller: _email,
    //                 hintText: "E-mail",
    //               ),
    //               CustomTextField(
    //                 data: Icons.person,
    //                 isObsecure: true,
    //                 controller: _pass,
    //                 hintText: "Password",
    //               ),
    //               CustomTextField(
    //                 data: Icons.person,
    //                 isObsecure: true,
    //                 controller: _confirmPass,
    //                 hintText: "Confirm Password",
    //               ),
    //             ],
    //           ),
    //         ),
    //         ElevatedButton(
    //           onPressed: () {
    //             uploadandSaveImage();
    //           },
    //           style: ButtonStyle(
    //             backgroundColor: MaterialStateProperty.all(Colors.pink),
    //           ),
    //           child: Text(
    //             'SignUp',
    //             style: TextStyle(
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Container(
    //           width: _screenWidth * 0.8,
    //           height: 4.0,
    //           color: Colors.pink,
    //         ),
    //         SizedBox(
    //           height: 15,
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
