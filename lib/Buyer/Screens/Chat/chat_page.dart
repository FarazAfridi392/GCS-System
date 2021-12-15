import 'package:e_shop/Buyer/Screens/Chat/chat_detail_page.dart';
import 'package:e_shop/Buyer/Screens/Chat/chat_with_seller.dart';
import 'package:e_shop/Buyer/Screens/Chat/helper/theme.dart';
import 'package:e_shop/Buyer/Screens/Chat/services/database.dart';
import 'package:e_shop/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'helper/helperfunctions.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print(EcommerceApp.auth.currentUser.email);
                  return ChatRoomsTile(
                    email: snapshot.data.docs[index]['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(EcommerceApp.auth.currentUser.email, ""),
                    chatRoomId: snapshot.data.docs[index]["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    DatabaseMethods()
        .getUserChats(EcommerceApp.auth.currentUser.email)
        .then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${EcommerceApp.auth.currentUser.email}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Conversations",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          centerTitle: false,
        ),
        body: Container(
          child: chatRoomsList(),
        ),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String email;
  final String chatRoomId;

  ChatRoomsTile({
    this.email,
    @required this.chatRoomId,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatWithSeller(
                          email: email,
                          chatRoomId: chatRoomId,
                        )));
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.orangeAccent.shade100),
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/background.jpg"),
                        maxRadius: 30,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                email,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // child: Container(
          //   color: Colors.black26,
          //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          //   child: Row(
          //     children: [
          //       Container(
          //         height: 30,
          //         width: 30,
          //         decoration: BoxDecoration(
          //             color: CustomTheme.colorAccent,
          //             borderRadius: BorderRadius.circular(30)),
          //         child: Text(userName.substring(0, 1),
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontFamily: 'OverpassRegular',
          //                 fontWeight: FontWeight.w300)),
          //       ),
          //       SizedBox(
          //         width: 12,
          //       ),
          //       Text(userName,
          //           textAlign: TextAlign.start,
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 16,
          //               fontFamily: 'OverpassRegular',
          //               fontWeight: FontWeight.w300))
          //     ],
          //   ),
          // ),
        ),
      ],
    );
  }
}



// import 'package:e_shop/Buyer/models/chatUser.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import 'Components/conversation_list.dart';

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   List<ChatUsers> chatUsers = [
//     ChatUsers(
//         name: "Hanzla Ahmed",
//         messageText: "Awesome Setup",
//         imageURL: "assets/background.jpg",
//         time: "Now"),
//     ChatUsers(
//         name: "Ahmed Ashraf",
//         messageText: "That's Great",
//         imageURL: "assets/background.jpg",
//         time: "Yesterday"),
//     ChatUsers(
//         name: "Atif Siddiqui",
//         messageText: "Hey where are you?",
//         imageURL: "assets/background.jpg",
//         time: "31 Mar"),
//     ChatUsers(
//         name: "Michel Jhon",
//         messageText: "Busy! Call me in 20 mins",
//         imageURL: "assets/background.jpg",
//         time: "28 Mar"),
//     ChatUsers(
//         name: "Farhan Ullah",
//         messageText: "Thankyou, It's awesome",
//         imageURL: "assets/background.jpg",
//         time: "23 Mar"),
//     ChatUsers(
//         name: "Raheel Khan",
//         messageText: "will update you in evening",
//         imageURL: "assets/background.jpg",
//         time: "17 Mar"),
//     ChatUsers(
//         name: "Anees-ur-Rehman",
//         messageText: "Can you please share the file?",
//         imageURL: "assets/background.jpg",
//         time: "24 Feb"),
//     ChatUsers(
//         name: "Marvi Sarmad",
//         messageText: "How are you?",
//         imageURL: "assets/background.jpg",
//         time: "18 Feb"),
//   ];
//   List<ChatUsers> searchResults;
//   TextEditingController searchController = TextEditingController();

//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     searchResults = chatUsers;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.only(top: kToolbarHeight - 10),
//         padding: EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.only(bottom: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
                    
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 16.0),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(5)),
//                 color: Colors.white,
//               ),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Search',
//                     prefixIcon: SvgPicture.asset(
//                       'assets/icons/search_icon.svg',
//                       fit: BoxFit.scaleDown,
//                     )),
//                 onChanged: (value) {
//                   if (value.isNotEmpty) {
//                     List<ChatUsers> tempList = List<ChatUsers>();
//                     chatUsers.forEach((chatUser) {
//                       if (chatUser.name.toLowerCase().contains(value)) {
//                         tempList.add(chatUser);
//                       }
//                     });
//                     setState(() {
//                       searchResults.clear();
//                       searchResults.addAll(tempList);
//                     });
//                     return;
//                   } else {
//                     setState(() {
//                       searchResults.clear();
//                       searchResults.addAll(chatUsers);
//                     });
//                   }
//                 },
//               ),
//             ),
//             Flexible(
//               child: ListView.builder(
//                 itemCount: chatUsers.length,
//                 padding: EdgeInsets.only(top: 16),
//                 itemBuilder: (context, index) {
//                   return ConversationList(
//                     name: chatUsers[index].name,
//                     messageText: chatUsers[index].messageText,
//                     imageUrl: chatUsers[index].imageURL,
//                     time: chatUsers[index].time,
//                     isMessageRead: (index == 0 || index == 3) ? true : false,
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
