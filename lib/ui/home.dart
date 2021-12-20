import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../util/constants.dart';
import 'Playlists.dart';
import 'songs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int SONGS = 0;
  static const int PLAYLISTS = 1;
  int _selectedTab = SONGS;
  Widget _currPage = SongsPage();
  Duration duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: PageTransitionSwitcher(
            child: _currPage,
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
          ),
        ),
        Positioned(
          left: 16,
          top: 50,
          child: _buildVerticalTabs(),
        ),
        Positioned(
          bottom: Consts.firstExtent + 24,
          left: 16,
          child: _newPlaylist(),
        )
      ],
    );
  }

  IgnorePointer _newPlaylist() {
    return IgnorePointer(
      ignoring: _selectedTab != PLAYLISTS,
      child: AnimatedOpacity(
        opacity: _selectedTab == PLAYLISTS ? 1 : 0,
        curve: _selectedTab == PLAYLISTS
            ? Curves.easeInQuart
            : Curves.easeOutQuart,
        duration: Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: () {},
          child: RotatedBox(
            quarterTurns: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New playlist',
                style: MyStyles.verticalTabsSelected,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildVerticalTabs() {
    return RotatedBox(
      quarterTurns: 3,
      child: Row(
        children: [
          _buildTabsItem(text: 'Playlists', index: PLAYLISTS),
          SizedBox(
            width: 30,
          ),
          _buildTabsItem(text: 'All songs', index: SONGS),
        ],
      ),
    );
  }

  _buildTabsItem({String text, int index}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if (_selectedTab != index) {
            // actually changed
            if (index == SONGS)
              _currPage = SongsPage();
            else
              _currPage = PlaylistPage();
          }
          _selectedTab = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            AnimatedContainer(
              duration: duration,
              curve: Curves.bounceOut,
              width: (_selectedTab == index) ? 6 : 0,
              height: (_selectedTab == index) ? 6 : 0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            AnimatedDefaultTextStyle(
              style: (_selectedTab == index)
                  ? MyStyles.verticalTabsSelected
                  : MyStyles.verticalTabsUnSelected,
              duration: duration,
              curve: Curves.easeOut,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
