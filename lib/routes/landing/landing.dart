import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
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
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (Widget child, Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _getPage(_pageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _getNavBarItem(iconData: Icons.supervised_user_circle, title: "Match Maker"),
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

  Widget _getPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return MatchMaker(key: ValueKey(pageIndex));
        break;
      case 1:
        return ChatList(key: ValueKey(pageIndex));
        break;
      case 2:
        return Home(
          key: ValueKey(pageIndex),
        );
        break;
      case 3:
        return ProfileUpdate(
          key: ValueKey(pageIndex),
        );
        break;
      case 4:
        return FlashcardsPage(
          key: ValueKey(pageIndex),
        );
        break;
      default:
        print(pageIndex);
        throw Exception("Not Implemented $pageIndex");
    }
  }

  BottomNavigationBarItem _getNavBarItem({IconData iconData, String title}) {
    return BottomNavigationBarItem(
        icon: Icon(iconData),
        title: Text(title),
        backgroundColor: Colors.black);
  }
}
