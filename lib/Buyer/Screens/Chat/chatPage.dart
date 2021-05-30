import 'package:e_shop/Buyer/models/chatUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Components/conversation_list.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Hanzla Ahmed",
        messageText: "Awesome Setup",
        imageURL: "assets/background.jpg",
        time: "Now"),
    ChatUsers(
        name: "Ahmed Ashraf",
        messageText: "That's Great",
        imageURL: "assets/background.jpg",
        time: "Yesterday"),
    ChatUsers(
        name: "Atif Siddiqui",
        messageText: "Hey where are you?",
        imageURL: "assets/background.jpg",
        time: "31 Mar"),
    ChatUsers(
        name: "Michel Jhon",
        messageText: "Busy! Call me in 20 mins",
        imageURL: "assets/background.jpg",
        time: "28 Mar"),
    ChatUsers(
        name: "Farhan Ullah",
        messageText: "Thankyou, It's awesome",
        imageURL: "assets/background.jpg",
        time: "23 Mar"),
    ChatUsers(
        name: "Raheel Khan",
        messageText: "will update you in evening",
        imageURL: "assets/background.jpg",
        time: "17 Mar"),
    ChatUsers(
        name: "Anees-ur-Rehman",
        messageText: "Can you please share the file?",
        imageURL: "assets/background.jpg",
        time: "24 Feb"),
    ChatUsers(
        name: "Marvi Sarmad",
        messageText: "How are you?",
        imageURL: "assets/background.jpg",
        time: "18 Feb"),
  ];
  List<ChatUsers> searchResults;
  TextEditingController searchController = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();
    searchResults = chatUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight - 10),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.white,
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/search_icon.svg',
                      fit: BoxFit.scaleDown,
                    )),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    List<ChatUsers> tempList = List<ChatUsers>();
                    chatUsers.forEach((chatUser) {
                      if (chatUser.name.toLowerCase().contains(value)) {
                        tempList.add(chatUser);
                      }
                    });
                    setState(() {
                      searchResults.clear();
                      searchResults.addAll(tempList);
                    });
                    return;
                  } else {
                    setState(() {
                      searchResults.clear();
                      searchResults.addAll(chatUsers);
                    });
                  }
                },
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: chatUsers.length,
                padding: EdgeInsets.only(top: 16),
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
