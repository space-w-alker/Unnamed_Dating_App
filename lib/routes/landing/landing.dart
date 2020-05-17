import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/authentication.dart';
import '../../services/firestore.dart';
import 'package:provider/provider.dart';
import 'package:unnameddatingapp/pages/profile_update/profile_update_controller.dart';
import '../../pages/chat_list/chat_list.dart';
import '../../pages/flashcards_page/flashcards_page.dart';
import '../../pages/home/home.dart';
import '../../pages/matchmaker/matchmaker.dart';
import '../../pages/profile_update/profile_update.dart';

class LandingRoute extends StatefulWidget {
  @override
  _LandingRouteState createState() => _LandingRouteState();
}

class _LandingRouteState extends State<LandingRoute> {
  int _pageIndex = 3;
  @override
  Widget build(BuildContext context) {
    Authentication.signInAnonym();
    return Scaffold(
      body: IndexedStack(
        index: _pageIndex,
        children: <Widget>[
          MatchMaker(key: ValueKey(0)),
          ChatList(key: ValueKey(1)),
          Home(key: ValueKey(2)),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return ProfileUpdateController();
            },
            child: ProfileUpdate(key: ValueKey(3)),
          ),
          FlashcardsPage(key: ValueKey(4))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _getNavBarItem(
              iconData: Icons.supervised_user_circle, title: "Match Maker"),
          _getNavBarItem(iconData: Icons.chat, title: "Chats"),
          _getNavBarItem(iconData: Icons.home, title: "Home"),
          _getNavBarItem(iconData: Icons.account_box, title: "Update Profile"),
          _getNavBarItem(iconData: Icons.announcement, title: "Flashcards"),
        ],
        currentIndex: _pageIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _getNavBarItem({IconData iconData, String title}) {
    return BottomNavigationBarItem(
        icon: Icon(iconData),
        title: Text(title),
        backgroundColor: Colors.black);
  }
}
