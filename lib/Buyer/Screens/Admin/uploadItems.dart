import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/config.dart';
import 'package:e_shop/Buyer/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File file;
  TextEditingController _description = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _shortInfo = TextEditingController();
  String productID = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  takeImage(con) {
    return showDialog(
      context: con,
      builder: (_) {
        return SimpleDialog(
          title: Text(
            "Item Image",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(
                "Capture with Camera",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: captureWithCamera,
            ),
            SimpleDialogOption(
              child: Text(
                "Upload from Gallery",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: uploadFromGallery,
            ),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  captureWithCamera() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 680, maxWidth: 970);

    setState(() {
      file = imageFile;
    });
  }

  uploadFromGallery() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      file = imageFile;
    });
  }

  uploadProduct() {
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
        leading: IconButton(
          icon: Icon(
            Icons.border_color,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: () {
              EcommerceApp.auth.signOut().then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SplashScreen(),
                      ),
                    ),
                  );
            },
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: adminHomeScreenBody(),
    );
  }

  adminHomeScreenBody() {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.pink, Colors.lightGreenAccent],
            begin: new FractionalOffset(0.0, 0.0),
            end: new FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.shop_two,
              color: Colors.white,
              size: 200,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  takeImage(context);
                },
                child: Text(
                  "Add New Item",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadFormScreen() {
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
        leading: IconButton(
          onPressed: clearFormInfo,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "New Product",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: uploading ? null : () => uploadImageAndSaveItemInfo(),
            child: Text(
              "Add",
              style: TextStyle(
                color: Colors.pink,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading ? linearProgress() : Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(file),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _shortInfo,
                decoration: InputDecoration(
                  hintText: "Short Info",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _title,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _description,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
        ],
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      file = null;
      _description.clear();
      _price.clear();
      _shortInfo.clear();
      _title.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });

    String downloadUrl = await uploadItemImage(file);
    saveItemInfo(downloadUrl);
  }

  Future<String> uploadItemImage(mFileImage) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("items");
    StorageUploadTask uploadTask =
        storageReference.child("product_$productID.jpg").putFile(mFileImage);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downUrl) {
    final itemsRef = Firestore.instance.collection("items");
    itemsRef.document(productID).setData({
      "shortInfo": _shortInfo.text.trim(),
      "longDescription": _description.text.trim(),
      "price": int.parse(_price.text),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downUrl,
      "title": _title.text.trim(),
    });

    setState(() {
      file = null;
      uploading = false;
      productID = DateTime.now().millisecondsSinceEpoch.toString();
      _description.clear();
      _title.clear();
      _shortInfo.clear();
      _price.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? uploadProduct() : uploadFormScreen();
  }
}
