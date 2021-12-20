import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
Map<String, dynamic> _artists = {
  'Sadegh': [0, 2, 3, 4],
  'Bellie Eilish': [2, 6, 11, 10, 14, 5, 7, 8],
  'Epicure': [2, 3, 4, 5],
  'Fadaei': [1, 4],
  'Sam Smith': [10, 14, 13, 8],
  'Ho3ein': [9, 3, 2, 3, 4, 5],
  'Imagin Dragons': [3, 4, 5, 6, 7, 8, 9, 11, 13],
  'Lewis Capaldi': [14, 6, 3, 2, 1, 5],
  'Eminem': [9, 10, 11],
  'Eminem & Drake & Kanye West': [3, 4, 5],
  'Camila Cabello': [3, 4, 0, 5, 7, 11],
};

class ArtistsPage extends StatefulWidget {
  @override
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
          top: 20, left: 40, right: 40, bottom: Consts.firstExtent + 20),
      physics: BouncingScrollPhysics(),
      itemCount: _artists.keys.length,
      itemBuilder: (context, index) =>
          _buildArtistItem(_artists.keys.toList()[index]),
    );
  }

  Widget _buildArtistItem(String artistKey) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.border,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 12, left: 20, right: 20),
                child: Text(
                  artistKey,
                  style: MyStyles.artistName,
                  maxLines: 1,
                ),
              ),
              ArtworkList(
                artistKey: artistKey,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 16, left: 20),
                child: Text(
                  '3 Albums, 23 songs',
                  style: MyStyles.artistDetails,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArtworkList extends StatefulWidget {
  const ArtworkList({
    Key key,
    @required this.artistKey,
  }) : super(key: key);

  final String artistKey;

  @override
  _ArtworkListState createState() => _ArtworkListState();
}

class _ArtworkListState extends State<ArtworkList> {
  double size = 36;
  List<int> idxs;

  @override
  void initState() {
    super.initState();
    idxs = _artists[widget.artistKey] as List<int>;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size,
      ),
      child: ListView.builder(
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: idxs.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: SizedBox(
              height: size,
              width: size,
              child: ClipOval(
                child: Image.asset(
                  _artworks[idxs[index]],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
