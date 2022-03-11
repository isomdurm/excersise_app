import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:toyota_app/helpers/storage_helper.dart';

import 'home/home_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {

  int _currentTabIndex = 0;
  bool _isFetchingData = false;

  final _page1 = GlobalKey<NavigatorState>();
  final _page2 = GlobalKey<NavigatorState>();
  final _page3 = GlobalKey<NavigatorState>();
  final _page4 = GlobalKey<NavigatorState>();
  final _page5 = GlobalKey<NavigatorState>();

  @override
  initState() {
    super.initState();

    _getStartup();
  }

  // make api call to fetch data
  void _getStartup() async {
    var _savedTab = await StorageHelper.readData('selectedTab') ?? 0;

    setState(() {
      _currentTabIndex = _savedTab;
      _isFetchingData = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTabTapped(int index) {
    StorageHelper.saveData('selectedTab', index);

    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped, // new
          currentIndex: _currentTabIndex, // new
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Badge(
                showBadge: false,
                badgeContent: const Text(''),
                child: Icon(
                    MdiIcons.fromString('home-variant-outline'),
                    size: 35.0
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Badge(
                showBadge: false,
                badgeContent: const Text(''),
                child: Icon(
                  MdiIcons.fromString('message-outline'),
                  size: 35.0,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Badge(
                showBadge: false,
                badgeContent: const Text(''),
                child: Icon(
                    MdiIcons.fromString('cards-heart-outline'),
                    size: 35.0
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Badge(
                showBadge: false,
                badgeContent: const Text(''),
                child: Icon(
                    MdiIcons.fromString('file-document-outline'),
                    size: 35.0
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Badge(
                showBadge: true,
                badgeColor: const Color(0xff00cc66),
                position: BadgePosition.topStart(),
                badgeContent: const Text(''),
                child: Icon(
                  MdiIcons.fromString('cog-outline'),
                  size: 35.0,
                ),
              ),
            ),
          ],
          selectedItemColor: Colors.black,
        ),
      ),
      body: _isFetchingData ? Container(
        color: const Color(0xffffebf9),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffffb8ea)),
                strokeWidth: 2.0,
              ),
            ),
          ],
        ),
      ) : IndexedStack(
        index: _currentTabIndex,
        children: <Widget>[
          Navigator(
            key: _page1,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const HomeScreen(),
            ),
          ),
          Navigator(
            key: _page2,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const HomeScreen(),
            ),
          ),
          Navigator(
            key: _page3,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const HomeScreen(),
            ),
          ),
          Navigator(
            key: _page4,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const HomeScreen(),
            ),
          ),
          Navigator(
            key: _page5,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const HomeScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

