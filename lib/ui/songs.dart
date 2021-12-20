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
List<String> _titles = [
  'Baal',
  'Befor i go',
  'Elahi alafv',
  'Dige tablo shode',
  'Fire on fire',
  'Sob Zohr Shab',
  'Natural',
  'Someonen you loved',
  'Love the wat you lie',
  'Godzilla',
  'Forever',
  'Bad husband',
  'Napors',
  'Senorita',
  'Sorkh'
];
List<String> _artists = [
  'Sadegh',
  'Bellie Eilish',
  'Epicure',
  'Fadaei',
  'Sam Smith',
  'Ho3ein',
  'Imagin Dragons',
  'Lewis Capaldi',
  'Eminem FT. Rihanna',
  'Eminem',
  'Eminem & Drake & Kanye West',
  'Eminem',
  'Sadegh',
  'Camila Cabello',
  'Sadegh'
];

class SongsPage extends StatefulWidget {
  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
        left: 70,
        right: 40,
        top: 20,
        bottom: Consts.firstExtent,
      ),
      itemCount: _artworks.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return MusicTile(index: index);
      },
    );
  }
}

class MusicTile extends StatefulWidget {
  final int index;
  final bool darkTextStyle;

  MusicTile({this.index, this.darkTextStyle = true});

  @override
  _MusicTileState createState() => _MusicTileState(index);
}

class _MusicTileState extends State<MusicTile> {
  int index;

  _MusicTileState(this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              _artworks[index],
              fit: BoxFit.cover,
              width: 58,
              height: 58,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 58,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _titles[index],
                    style: widget.darkTextStyle
                        ? MyStyles.songTitleDark
                        : MyStyles.songTitleLight,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          _artists[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: widget.darkTextStyle
                              ? MyStyles.songArtistDark
                              : MyStyles.songArtistLight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          '02:25',
                          style: widget.darkTextStyle
                              ? MyStyles.songArtistDark
                              : MyStyles.songArtistLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
