import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'ui/Albums.dart';
import 'ui/Artists.dart';
import 'ui/Folders.dart';
import 'ui/home.dart';
import 'ui/nowPlaying.dart';
import 'util/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // timeDilation = 3;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(
          primaryColor: MyColors.colorPrimary,
          fontFamily: 'product',
          canvasColor: Colors.white),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  bool _isPlaying = true;
  int _navBarIndex = 0;
  Widget _currPage = HomePage();
  String _appBatTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                _buildAppbar(),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPlaying = true;
                      });
                    },
                    child: PageTransitionSwitcher(
                      child: _currPage,
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (child, primaryAnimation, secondaryAnimation) {
                        return FadeThroughTransition(
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: _isPlaying ? Curves.easeOutBack : Curves.easeInBack,
            bottom: _isPlaying ? 0 : 1 - Consts.firstExtent,
            right: 0,
            left: 0,
            child: _buildPlayingBar(context),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: _buildBottomNavBar(context),
          )
        ],
      ),
    );
  }

  _buildAppbar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 8,
          top: 8 + MediaQuery.of(context).padding.top,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/svg/ic-menu.svg',
                width: 16,
              ),
              onPressed: () {},
            ),
            Text(
              _appBatTitle,
              style: MyStyles.appbarTitle,
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/svg/ic-search.svg',
                width: 16,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  _buildPlayingBar(BuildContext context) {
    return IgnorePointer(
      ignoring: !_isPlaying,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 300),
                pageBuilder: (context, animation, secAnimation) => NowPlaying(),
                transitionsBuilder: (context, animation, secAnimation, child) =>
                    SharedAxisTransition(
                      transitionType: SharedAxisTransitionType.vertical,
                      animation: animation,
                      secondaryAnimation: secAnimation,
                      child: child,
                    )),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: SizedBox(
            height: Consts.secondExtent,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: Consts.firstExtent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'IMG',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(26),
                            child: Image.asset(
                              'assets/images/lewis capaldi.jpg',
                              fit: BoxFit.cover,
                              width: 52,
                              height: 52,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Someone you loved',
                                  style: MyStyles.songTitleLight,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  'Lewis Capaldi',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: MyStyles.songArtistLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            _isPlaying
                                ? 'assets/svg/ic-pause.svg'
                                : 'assets/svg/ic-play.svg',
                            color: Colors.white,
                            height: 16,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPlaying = false;
                            });
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/ic-forward.svg',
                            color: Colors.white,
                            height: 18,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBottomNavBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Container(
        color: Colors.white,
        child: SizedBox(
          height: Consts.firstExtent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: _navBarIndex,
              backgroundColor: Colors.white,
              onTap: (index) => _onNavChanged(context, index),
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _navBarIndex == 0
                        ? 'assets/svg/ic-home-filled.svg'
                        : 'assets/svg/ic-home.svg',
                    height: 22,
                  ),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _navBarIndex == 1
                        ? 'assets/svg/ic-artists-filled.svg'
                        : 'assets/svg/ic-artists.svg',
                    height: 22,
                  ),
                  title: Text('Artists'),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _navBarIndex == 2
                        ? 'assets/svg/ic-albums-filled.svg'
                        : 'assets/svg/ic-albums.svg',
                    height: 22,
                  ),
                  title: Text('Albums'),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _navBarIndex == 3
                        ? 'assets/svg/ic-folders-filled.svg'
                        : 'assets/svg/ic-folders.svg',
                    height: 22,
                  ),
                  title: Text('Folders'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onNavChanged(BuildContext context, int index) {
    if (_navBarIndex != index)
      setState(() {
        _navBarIndex = index;
        switch (_navBarIndex) {
          case 0:
            _currPage = HomePage();
            _appBatTitle = 'Home';
            break;
          case 1:
            _currPage = ArtistsPage();
            _appBatTitle = 'Artists';
            break;
          case 2:
            _currPage = AlbumsPage();
            _appBatTitle = 'Albums';
            break;
          case 3:
            _currPage = FoldersPage();
            _appBatTitle = 'Folders';
            break;
        }
      });
  }
}
