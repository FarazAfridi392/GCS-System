import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Seller/Screens/SellerShop/add_location.dart';
import 'package:e_shop/Seller/Screens/SellerShop/seller_shop.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/config.dart';
import 'package:e_shop/Buyer/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CreateShop extends StatefulWidget {
  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop>
    with AutomaticKeepAliveClientMixin<CreateShop> {
  bool get wantKeepAlive => true;
  PickedFile file;
  TextEditingController _shopName = TextEditingController();
  TextEditingController _shopOwner = TextEditingController();
  TextEditingController _adress = TextEditingController();

  TextEditingController _contact = TextEditingController();
  TextEditingController _shopDescription = TextEditingController();
  bool shopCreated = false;

  String shopId = EcommerceApp.auth.currentUser.uid;

  bool uploading = false;

  takeImage(con) {
    return showDialog(
      context: con,
      builder: (_) {
        return SimpleDialog(
          title: Text(
            "Shop Image",
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
    // ignore: omit_local_variable_types
    File imageFile = (await ImagePicker().getImage(
        source: ImageSource.camera, maxHeight: 680, maxWidth: 970)) as File;

    setState(() {
      file = imageFile as PickedFile;
    });
  }

  // ignore: always_declare_return_types
  uploadFromGallery() async {
    Navigator.pop(context);
    // ignore: omit_local_variable_types
    PickedFile imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      file = imageFile;
    });
  }

  // ignore: always_declare_return_types
  createShop() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Shop"),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: kYellow),
        ),
      ),
      body: Center(
        child: addShopScreenBody(),
      ),
    );
  }

  addShopScreenBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset(
                'assets/icons/store.svg',
              ),
              height: 200,
            ),
            Text(
              "You don't have any shop register.",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 70),
              child: ElevatedButton(
                onPressed: () {
                  takeImage(context);
                },
                child: Text(
                  "Create One",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kYellow),
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
        backgroundColor: kYellow,
        leading: IconButton(
          onPressed: clearFormInfo,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'New Shop',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: uploading ? null : uploadImageAndSaveItemInfo,
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(file.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 12)),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
                controller: _shopName,
                decoration: const InputDecoration(
                  hintText: "Shop Name",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
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
                controller: _shopOwner,
                decoration: const InputDecoration(
                  hintText: "Owner Name",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
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
                controller: _adress,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Adress",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
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
                controller: _contact,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Contact",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
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
                controller: _shopDescription,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Shop Description",
                  hintStyle: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pink,
          ),
        ],
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      file = null;
      _shopName.clear();
      _shopOwner.clear();

      _adress.clear();
      _contact.clear();
      _shopDescription.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });

    String downloadUrl = await uploadItemImage(file);
    await saveItemInfo(downloadUrl);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddLocation(),
      ),
    );
  }

  Future<String> uploadItemImage(mFileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("items");
    // ignore: omit_local_variable_types
    UploadTask uploadTask =
        // ignore: prefer_single_quotes
        storageReference
            .child("product_$shopId.jpg")
            .putFile(File(mFileImage.path));
    TaskSnapshot snapshot = await uploadTask;
    // ignore: omit_local_variable_types
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downUrl) {
    final itemsRef = FirebaseFirestore.instance.collection("Shop");
    final dateTime = DateTime.now();
    final formatedDateTime =
        "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    itemsRef.doc(shopId).set({
      'shopId': shopId.toString(),
      "Email": EcommerceApp.auth.currentUser.email,
      "ShopName": _shopName.text.trim(),
      "ShopOwner": _shopOwner.text,
      "Date_Created": formatedDateTime,
      "status": "available",
      "thumbnailUrl": downUrl,
      "Address": _adress.text.trim(),
      "Contact": _contact.text.trim(),
      "Shop_Description": _shopDescription.text.trim(),
    });

    setState(() {
      file = null;
      uploading = false;
      shopId = DateTime.now().millisecondsSinceEpoch.toString();
      _shopName.clear();
      _adress.clear();

      _shopOwner.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseFirestore.instance.collection("Shop").doc(shopId).toString());
    print(shopId);

    // return retrunType == null ? createShop() : MyShop();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Shop').snapshots(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          var doc = snapshot.data.docs;

          // ignore: omit_local_variable_types
          for (int i = 0; i < snapshot.data.docs.length; i++) {
            if (doc[i]['shopId'].toString() ==
                EcommerceApp.auth.currentUser.uid.toString()) {
              shopCreated = true;
              return MyShop();
            }
          }
          if (shopCreated == false) {
            print(shopCreated);
            return file == null ? createShop() : uploadFormScreen();
          }

          // if (snapshot.data.docs.contains() == null) {
          //   return createShop();
          // } else {
          //   return MyShop();
          // }
        },
      ),
    );
  }
}
