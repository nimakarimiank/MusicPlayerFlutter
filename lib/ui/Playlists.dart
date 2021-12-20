import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../util/constants.dart';

List<String> _artworks = [
  'assets/images/baal.jpg',
  'assets/images/billie.jpg',
  'assets/images/elahi alafv.jpg',
  'assets/images/fadaei.jpg',
  'assets/images/fire on fire.jpg',
  'assets/images/images.png',
  'assets/images/imagine dragon.jpg',
  'assets/images/lewis capaldi.jpg',
  'assets/images/love the way you lie.jpg',
  'assets/images/music to be murdered by.jpg',
  'assets/images/relapse.jpg',
  'assets/images/revival.jpg',
  'assets/images/sadegh.jpg',
  'assets/images/senorita.jpg',
  'assets/images/sorkh.jpg'
];

List<String> _playlists = [
  'Recently added',
  'Top 2020 hits',
  'Dep',
  'Disslove',
  'Liked'
];

class PlaylistPage extends StatefulWidget {
  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _playlists.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: 70,
        right: 40,
        bottom: Consts.firstExtent + 15,
        top: 20,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            PlayListCover(),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Text(
                _playlists[index],
                maxLines: 2,
                style: MyStyles.songTitleDark,
              ),
            ),
          ],
        );
      },
    );
  }
}

class PlayListCover extends StatefulWidget {
  @override
  _PlayListCoverState createState() => _PlayListCoverState();
}

class _PlayListCoverState extends State<PlayListCover> {
  List<String> selected = [];

  // the amount of space between image artworks in playlist cover
  double _dividerW = 3;

  @override
  void initState() {
    super.initState();
    while (selected.length < 3) {
      int rand = Random().nextInt(_artworks.length);
      if (!selected.contains(_artworks[rand])) selected.add(_artworks[rand]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: [
          Flexible(
            flex: 14,
            child: Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.asset(
                  selected[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: _dividerW,
          ),
          Flexible(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                      ),
                      child: Image.asset(
                        selected[1],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: _dividerW,
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                      ),
                      child: Image.asset(
                        selected[2],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
