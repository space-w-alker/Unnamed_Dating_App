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
  int _page_index = 0;

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
        child: _getPage(_page_index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.supervised_user_circle,
                //color: Colors.white,
              ),
              title: Text(
                "Match Maker",
                //style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                //color: Colors.white,
              ),
              title: Text(
                "Chat",
                //style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                //color: Colors.white,
              ),
              title: Text(
                "Home",
                //style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
                //color: Colors.white,
              ),
              title: Text(
                "Update Profile",
                //style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.textsms,
                //color: Colors.white,
              ),
              title: Text(
                "Flashcards",
                //style: TextStyle(color: Colors.white),
              )),
        ],
        currentIndex: _page_index,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _page_index = index;
          });
        },
      ),
    );
  }

  Widget _getPage(int page_index) {
    switch (page_index) {
      case 0:
        return MatchMaker(key: ValueKey(page_index));
        break;
      case 1:
        return ChatList(key: ValueKey(page_index));
        break;
      case 2:
        return Home(
          key: ValueKey(page_index),
        );
        break;
      case 3:
        return ProfileUpdate(
          key: ValueKey(page_index),
        );
        break;
      case 4:
        return FlashcardsPage(
          key: ValueKey(page_index),
        );
        break;
      default:
        print(page_index);
        throw Exception("Not Implemented $page_index");
    }
  }
}
