import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../util/constants.dart';

const int STORAGE = 0;
const int SD_CARD = 1;

class FoldersPage extends StatefulWidget {
  @override
  _FoldersPageState createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  int _selectedTab = STORAGE;
  Duration _duration = Duration(milliseconds: 300);
  Widget _currPage = FoldersView(root: STORAGE);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: PageTransitionSwitcher(
            child: _currPage,
            duration: _duration,
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
      ],
    );
  }

  _buildVerticalTabs() {
    return RotatedBox(
      quarterTurns: 3,
      child: Row(
        children: [
          _buildTabsItem(text: 'SD Card', index: SD_CARD),
          SizedBox(
            width: 30,
          ),
          _buildTabsItem(text: 'Storage', index: STORAGE),
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
            if (index == STORAGE)
              _currPage = FoldersView(
                root: STORAGE,
                key: UniqueKey(),
              );
            else
              _currPage = FoldersView(
                root: SD_CARD,
                key: UniqueKey(),
              );
          }
          _selectedTab = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            AnimatedContainer(
              duration: _duration,
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
              duration: _duration,
              curve: Curves.easeOut,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}

class FoldersView extends StatefulWidget {
  FoldersView({this.root, Key key}) : super(key: key);

  final int root;

  @override
  _FoldersViewState createState() => _FoldersViewState();
}

class _FoldersViewState extends State<FoldersView> {
  Map<String, dynamic> folders;

  @override
  void initState() {
    super.initState();
    folders = (widget.root == STORAGE)
        ? {
            'Downloads': {
              'path': 'Storage/Downloads',
              '0': {
                'title': 'You Don\'t know',
                'artist': 'Eminem FT 50Cent, Cashis, Lioyd Banks'
              },
            },
            'Telegram Music': {
              'path': 'Storage/Telegram/Telegram Music',
              '0': {'title': 'Money Mouf', 'artist': 'Tyga'},
              '1': {'title': 'MAMACITA', 'artist': 'Tyga'},
            },
            'Music': {
              'path': 'Storage/Music',
              '0': {'title': 'Grace', 'artist': 'Lewis Capaldi'},
              '1': {'title': 'Bruises', 'artist': 'Lewis Capaldi'},
              '2': {
                'title': 'Hold me while you wait',
                'artist': 'Lewis Capaldi'
              },
              '3': {'title': 'Someone you loved', 'artist': 'Lewis Capaldi'},
              '4': {'title': 'maybe', 'artist': 'Lewis Capaldi'},
            },
            'Avaar - ali sorena': {
              'path': 'Storage/Music/avaar - ali sorena',
              '0': {'title': 'Be Bachat Begoo', 'artist': 'Ali Sorena'},
              '1': {'title': 'Nemitarsam', 'artist': 'Ali Sorena'},
              '2': {'title': 'Shorou', 'artist': 'Ali Sorena'},
              '3': {'title': 'majnoune Shahr', 'artist': 'Ali Sorena'},
              '4': {'title': 'Do Shab', 'artist': 'Ali Sorena'},
              '5': {'title': 'Atal Matal', 'artist': 'Ali Sorena'},
              '6': {'title': 'Avaar', 'artist': 'Ali Sorena'},
            },
          }
        : {
            'Ye Wan Tony - Arta': {
              'path': 'SD Card/Music/Ye Wan Tony - Arta',
              '0': {
                'title': 'Erade Kon',
                'artist': 'Arta FT Khashayar SR FT Koorosh'
              },
              '1': {
                'title': 'Cheshm Be Ham Bezani',
                'artist': 'Arta FT Koorosh'
              },
              '2': {'title': 'Hanooz Yadame', 'artist': 'Arta'},
            },
            'Sokoot - Bahram': {
              'path': 'SD Card/Music/Sokoot - bahram',
              '0': {'title': 'Intro', 'artist': 'Bahram'},
              '1': {'title': 'Jalebe', 'artist': 'Bahram'},
              '2': {'title': 'Harfaye Man', 'artist': 'Bahram'},
              '3': {'title': 'Az Man Bepors', 'artist': 'Bahram'},
              '4': {'title': 'Mano Bebakhsh', 'artist': 'Bahram'},
              '5': {'title': 'Dar Naro', 'artist': 'Bahram'},
              '6': {'title': 'Nasle Man', 'artist': 'Bahram'},
              '7': {'title': 'Be Chi Eteghad Dari', 'artist': 'Bahram'},
              '8': {'title': 'Khorshid Khanom', 'artist': 'Bahram'},
              '9': {'title': 'Yaghi', 'artist': 'Bahram'},
              '10': {'title': 'Ajib', 'artist': 'Bahram'},
              '11': {'title': 'Ye Hes', 'artist': 'Bahram'},
              '12': {'title': 'Outro', 'artist': 'Bahram'},
            },
          };
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          left: 70, right: 40, top: 15, bottom: Consts.firstExtent + 20),
      itemCount: folders.keys.length,
      itemBuilder: (context, index) =>
          FolderTile(folders: folders, index: index),
    );
  }
}

class FolderTile extends StatefulWidget {
  FolderTile({this.folders, this.index});

  final int index;
  final Map<String, dynamic> folders;

  @override
  _FolderTileState createState() => _FolderTileState();
}

class _FolderTileState extends State<FolderTile>
    with SingleTickerProviderStateMixin {
  bool _isOpened = false;
  Duration _duration = Duration(milliseconds: 400);

  // each individual song height
  static const double _songH = 48;

  // each individual song vertical padding
  static const double _songVertPadding = 12;

  // the whole songs list's vertical padding
  static const double _listVertPadding = 20;

  @override
  Widget build(BuildContext context) {
    // folder key that is actually its name in our example
    String folderKey = widget.folders.keys.toList()[widget.index];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _isOpened = !_isOpened;
        });
      },
      child: Column(
        children: [
          _buildFolderHeader(folderKey),
          _buildSongsList(folderKey),
        ],
      ),
    );
  }

  Widget _buildSongsList(String folderKey) {
    // calculate opened container height
    double songCount = (widget.folders[folderKey].keys.length - 1).toDouble();
    if (songCount > 7) songCount = 7.3;
    double _openedH =
        songCount * (_songH + _songVertPadding) + _listVertPadding;

    return AnimatedPadding(
      duration: _duration,
      padding: _isOpened
          ? EdgeInsets.only(top: 15, bottom: 15)
          : EdgeInsets.only(top: 5, bottom: 5),
      curve: Curves.easeOutQuint,
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeOutQuint,
        height: _isOpened ? _openedH : 0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(
                width: _isOpened ? 1 : 0,
                color: _isOpened ? MyColors.border : Colors.transparent)),
        child: ListView.builder(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: _listVertPadding / 2,
              bottom: _listVertPadding / 2),
          physics: BouncingScrollPhysics(),
          itemCount: (widget.folders[folderKey] as Map).keys.length - 1,
          itemBuilder: (context, i) => _songTile(folderKey, i),
        ),
      ),
    );
  }

  Widget _songTile(String folderKey, int i) {
    List songKeys = (widget.folders[folderKey] as Map).keys.toList();
    songKeys.removeAt(0);
    return Padding(
      padding: EdgeInsets.only(
          top: _songVertPadding / 2, bottom: _songVertPadding / 2),
      child: Container(
        height: _songH,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNumberSign(i),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.folders[folderKey][songKeys[i]]['title'],
                    style: MyStyles.songTitleDark,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.folders[folderKey][songKeys[i]]['artist'],
                    style: MyStyles.songArtistDark,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildFolderHeader(String fKey) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: MyColors.folders.withOpacity(0.35),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/svg/ic-folders-filled.svg',
                height: 20,
                color: MyColors.folders,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  fKey,
                  style: MyStyles.songTitleDark,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.folders[fKey]['path'],
                  style: MyStyles.songArtistDark,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/svg/ic-more.svg',
            width: 12,
            color: MyColors.textPrimaryDark,
          )
        ],
      ),
    );
  }

  Widget _buildNumberSign(int index) {
    index++;
    int digits = 1;
    if (index > 9) digits = 2;
    if (index > 99) digits = 3;
    if (index > 999) digits = 4;
    if (index > 9999) digits = 5;
    if (index > 99999) digits = 6;

    List<double> widths = [27, 35, 43, 51, 59, 67];
    return AnimatedContainer(
      duration: _duration,
      width: widths[digits - 1],
      height: 33,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: Center(
        child: Text(
          '$index',
          style: MyStyles.songTitleDark,
          maxLines: 1,
        ),
      ),
    );
  }
}
