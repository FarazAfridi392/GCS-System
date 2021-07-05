import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Buyer/Screens/Admin/uploadItems.dart';
import 'package:e_shop/Buyer/Widgets/customTextField.dart';
import 'package:e_shop/Buyer/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.pink, Colors.lightGreenAccent],
                begin: new FractionalOffset(0.0, 0.0),
                end: new FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Text(
          'e-Shop',
          style: TextStyle(
            fontSize: 55.0,
            color: Colors.white,
            fontFamily: "Signatra",
          ),
        ),
        centerTitle: true,
      ),
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void loginAdmin() {
    FirebaseFirestore.instance.collection("admins").get().then((value) {
      value.docs.forEach((element) {
        if (element["id"] != _id.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Your id is not correct"),
            ),
          );
        } else if (element["password"] != _pass.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Your password is not correct"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Welcom Dear Admin " + element['name'],
              ),
            ),
          );

          setState(() {
            _id.text = "";
            _pass.text = "";
          });

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return UploadPage();
          }));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.pink, Colors.lightGreenAccent],
              begin: new FractionalOffset(0.0, 0.0),
              end: new FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset("images/admin.png"),
              height: 240,
              width: 240,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Admin",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    isObsecure: false,
                    controller: _id,
                    hintText: "ID",
                  ),
                  CustomTextField(
                    data: Icons.person,
                    isObsecure: true,
                    controller: _pass,
                    hintText: "Password",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _id.text.isNotEmpty && _pass.text.isNotEmpty
                    ? loginAdmin()
                    : showDialog(
                        context: context,
                        builder: (_) {
                          return ErrorAlertDialog(
                            message: "Please type id and password",
                          );
                        },
                      );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: _screenWidth * 0.8,
              height: 4.0,
              color: Colors.pink,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.nature_people,
                color: Colors.pink,
              ),
              label: Text(
                "I'm not admin",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
