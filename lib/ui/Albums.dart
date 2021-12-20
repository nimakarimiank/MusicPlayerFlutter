import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  'assets/images/sorkh.jpg',
  'assets/images/images.png',
];
List<String> _albumTitles = [
  'Par',
  'When we all fall asleep, Where do we go?',
  'Epicure',
  'Sakhte Iran',
  'Sam Smith',
  'Ho3ein',
  'Imagin Dragons',
  'Lewis Capaldi',
  'Relapsed',
  'Music to be murdered by',
  'Recovery',
  'Revival',
  'Sarbaze khoda',
  'Camila Cabello',
  'Sadegh',
  'Yaad'
];

class AlbumsPage extends StatefulWidget {
  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  // this is album tile's height/width ratio
  double _bigTilesRatio = 1.35;
  double _smallTilesRatio = 1.15;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      padding: EdgeInsets.only(
          left: 40, right: 40, bottom: Consts.firstExtent, top: 20),
      itemCount: _artworks.length,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => Stack(
        children: [
          _buildTileImage(index),
          _buildTileGradient(index),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              '2020',
              style: MyStyles.songArtistLight,
              maxLines: 1,
            ),
          ),
          Positioned(
            bottom: 42,
            left: 20,
            right: 10,
            child: Text(
              _albumTitles[index],
              style: MyStyles.albumsTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
      staggeredTileBuilder: (index) => StaggeredTile.count(
          1, (index.isEven) ? _bigTilesRatio : _smallTilesRatio),
    );
  }

  Positioned _buildTileGradient(int index) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxW = constraints.maxWidth;
          // note that the even tiles are the bigger ones
          double gradientHeight = (index.isEven)
              ? (maxW * _bigTilesRatio) / 2
              : (maxW * _smallTilesRatio) / 2;
          return Container(
            height: gradientHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Positioned _buildTileImage(int index) {
    return Positioned.fill(
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          child: Image.asset(
            _artworks[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
