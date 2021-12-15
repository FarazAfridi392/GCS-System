import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Buyer/Screens/Chat/helper/constants.dart';
import 'package:e_shop/Buyer/Screens/Chat/services/database.dart';
import 'package:e_shop/Buyer/Screens/Chat/widget/widget.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/config.dart';
import 'package:flutter/material.dart';

class ChatWithSeller extends StatefulWidget {
  final String chatRoomId;
  final String email;

  ChatWithSeller({
    this.chatRoomId,
    this.email,
  });

  @override
  _ChatWithSellerState createState() => _ChatWithSellerState();
}

class _ChatWithSellerState extends State<ChatWithSeller> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Future getUserWithID(String userId) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('sellers')
        .doc(userId)
        .get();

    EcommerceApp.sharedPreferences
        .setString('senderEmail', docSnapshot.data()['email']);
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  print(EcommerceApp.auth.currentUser.email);
                  return MessageTile(
                    message: snapshot.data.docs[index]["message"],
                    sendByMe: EcommerceApp.auth.currentUser.email ==
                        snapshot.data.docs[index]["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": EcommerceApp.auth.currentUser.email,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    getUserWithID(
        EcommerceApp.sharedPreferences.getString(EcommerceApp.shopProduct));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/background.jpg"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.email,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: kDarkYellow,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageEditingController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        addMessage();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: kDarkYellow,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            color: sendByMe ? kYellow : Colors.grey.shade300),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}



// import 'package:e_shop/app_properties.dart';
// import 'package:e_shop/Buyer/models/chatUser.dart';
// import 'package:flutter/material.dart';

// class ChatDetailPage extends StatefulWidget {
//   @override
//   _ChatDetailPageState createState() => _ChatDetailPageState();
// }

// class _ChatDetailPageState extends State<ChatDetailPage> {
//   // List<ChatMessage> messages = [
//   //   ChatMessage(messageContent: "Hello, Sir", messageType: "receiver"),
//   //   ChatMessage(
//   //       messageContent: "Your order has been delivered?",
//   //       messageType: "receiver"),
//   //   ChatMessage(messageContent: "Okay thank you", messageType: "sender"),
//   //   ChatMessage(messageContent: "Have a great day", messageType: "receiver"),
//   //   ChatMessage(messageContent: "You too", messageType: "sender"),
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   flexibleSpace: SafeArea(
      //     child: Container(
      //       padding: EdgeInsets.only(right: 16),
      //       child: Row(
      //         children: <Widget>[
      //           IconButton(
      //             onPressed: () {
      //               Navigator.pop(context);
      //             },
      //             icon: Icon(
      //               Icons.arrow_back,
      //               color: Colors.black,
      //             ),
      //           ),
      //           SizedBox(
      //             width: 2,
      //           ),
      //           CircleAvatar(
      //             backgroundImage: AssetImage("assets/background.jpg"),
      //             maxRadius: 20,
      //           ),
      //           SizedBox(
      //             width: 12,
      //           ),
      //           Expanded(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 Text(
      //                   "Hanzla Ahmed",
      //                   style: TextStyle(
      //                       fontSize: 16, fontWeight: FontWeight.w600),
      //                 ),
      //                 SizedBox(
      //                   height: 6,
      //                 ),
      //                 Text(
      //                   "Online",
      //                   style: TextStyle(
      //                       color: Colors.grey.shade600, fontSize: 13),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Icon(
      //             Icons.settings,
      //             color: Colors.black,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
//       body: Stack(
//         children: <Widget>[
//           ListView.builder(
//             itemCount: messages.length,
//             shrinkWrap: true,
//             padding: EdgeInsets.only(top: 10, bottom: 10),
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Container(
//                 padding:
//                     EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
//                 child: Align(
//                   alignment: (messages[index].messageType == "receiver"
//                       ? Alignment.topLeft
//                       : Alignment.topRight),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: messages[index].messageType == "receiver"
//                           ? BorderRadius.circular(20)
//                           : BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(0)),
//                       color: (messages[index].messageType == "receiver"
//                           ? Colors.grey.shade200
//                           : kYellow),
//                     ),
//                     padding: EdgeInsets.all(16),
//                     child: Text(
//                       messages[index].messageContent,
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
          
//         ],
//       ),
//     );
//   }
// }
