import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_math/vector_math.dart' as vMath;

import '../util/constants.dart';
import 'songs.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying>
    with SingleTickerProviderStateMixin {
  Duration _duration = Duration(milliseconds: 450);
  bool _isShrank = false;
  AnimationController _controller;
  Animation _curvedAnim;
  double _screenW;
  double _screenH;

  // artwork top padding
  double _artworkPT;

  // artwork width/screen width = (widthFactor)
  double _artworkWF = 0.56;

  // progress bar height
  double _progressH = 65;

  // controls height
  double _controlsH = 52;

  // timer slider value
  double _progress = 0.2;

  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenW = MediaQuery.of(context).size.width;
    _screenH = MediaQuery.of(context).size.height;
    _artworkPT = _screenH * 0.1;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (!_isShrank)
          return Future.value(true);
        else if (!_controller.isAnimating) {
          setState(() {
            _isShrank = !_isShrank;
            _controller.reverse();
          });
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          color: MyColors.colorPrimary,
          child: Column(
            children: [
              _playingView(context),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!_controller.isAnimating)
                      setState(() {
                        _isShrank = !_isShrank;
                        if (_isShrank)
                          _controller.forward();
                        else
                          _controller.reverse();
                      });
                  },
                  child: ListView.builder(
                    itemCount: 10,
                    physics: _isShrank
                        ? BouncingScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                    itemBuilder: (context, index) => MusicTile(
                      index: index,
                      darkTextStyle: false,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _playingView(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _curvedAnim = _controller.drive(
          CurveTween(
              curve: _isShrank ? Curves.easeOutQuint : Curves.easeInQuint),
        );
        return Container(
          height: Tween<double>(
                  begin: MediaQuery.of(context).size.height - 98,
                  end: MediaQuery.of(context).padding.top + 105)
              .evaluate(_curvedAnim),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              color: Colors.white),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              children: [
                _backPositioned(),
                _morePositioned(),
                _artworkPositioned(),
                _songTitleArtist(),
                _controlsPositioned()
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned _backPositioned() {
    return Positioned(
      top: 16,
      left: 16,
      child: Transform.rotate(
        angle: vMath
            .radians(Tween<double>(begin: 0, end: -90).evaluate(_curvedAnim)),
        child: IconButton(
          onPressed: () {
            if (!_isShrank)
              Navigator.of(context).pop();
            else if (!_controller.isAnimating) {
              setState(() {
                _isShrank = !_isShrank;
                _controller.reverse();
              });
            }
          },
          icon: SvgPicture.asset(
            'assets/svg/ic-back.svg',
            width: 9,
          ),
        ),
      ),
    );
  }

  Positioned _morePositioned() {
    return Positioned(
      top: 8,
      right: Tween<double>(begin: 0, end: -35).evaluate(_curvedAnim),
      child: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/svg/ic-more.svg',
          width: 12,
        ),
      ),
    );
  }

  Positioned _artworkPositioned() {
    return Positioned(
      top: Tween<double>(begin: _artworkPT, end: 20).evaluate(_curvedAnim),
      left: Tween<double>(
        begin: _screenW * ((1 - _artworkWF) / 2),
        end: 65,
      ).evaluate(_curvedAnim),
      child: SizedBox(
        width: Tween<double>(
          begin: _screenW * _artworkWF,
          end: 52,
        ).evaluate(_curvedAnim),
        child: AspectRatio(
          aspectRatio: 1,
          child: Hero(
            tag: 'IMG',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  Tween<double>(begin: 25, end: 30).evaluate(_curvedAnim)),
              child: Image.asset(
                'assets/images/lewis capaldi.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _songTitleArtist() {
    String _songTitle = 'Someone you loved';
    String _artist = 'Lewis Capaldi';
    return Positioned(
      top: Tween<double>(
        begin: _screenW * _artworkWF + _artworkPT + _screenH * 0.03,
        end: 20,
      ).evaluate(_curvedAnim),
      left: Tween<double>(
        begin: 50,
        end: 135,
      ).evaluate(_curvedAnim),
      right: Tween<double>(
        begin: 50,
        end: 20,
      ).evaluate(_curvedAnim),
      height: Tween<double>(begin: 65, end: 60).evaluate(_curvedAnim),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentTween(
              begin: Alignment.center,
              end: Alignment.centerLeft,
            ).evaluate(_curvedAnim),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  _songTitle,
                  style: TextStyleTween(
                    begin: MyStyles.appbarTitle,
                    end: MyStyles.songTitleDark,
                  ).evaluate(_curvedAnim),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: _isShrank ? TextAlign.left : TextAlign.center,
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentTween(
              begin: Alignment.center,
              end: Alignment.centerLeft,
            ).evaluate(_curvedAnim),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  _artist,
                  style: TextStyleTween(
                    begin: MyStyles.playingArtistBegin,
                    end: MyStyles.songArtistDark,
                  ).evaluate(_curvedAnim),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: _isShrank ? TextAlign.left : TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _controlsPositioned() {
    return Positioned(
      left: 50,
      right: 50,
      bottom: 20,
      top: Tween<double>(
        begin: _screenW * _artworkWF + _artworkPT + 55 + _screenH * 0.03,
        end: 200,
      ).evaluate(_curvedAnim),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double padding =
              max(constraints.maxHeight - (_progressH + _controlsH), 0);
          padding = (padding / 4);
          return SizedBox(
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: padding),
                  SizedBox(
                    height: _progressH,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Spacer(),
                          SliderTheme(
                            data: SliderThemeData(
                                trackHeight: 20,
                                thumbColor: Colors.transparent,
                                activeTrackColor: MyColors.colorPrimary,
                                inactiveTrackColor:
                                    MyColors.colorPrimary.withOpacity(0.3),
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 0,
                                  disabledThumbRadius: 0,
                                ),
                                overlayColor: Colors.transparent,
                                trackShape: WaveFormTrackShape()),
                            child: Slider(
                              value: _progress,
                              onChanged: (value) {
                                setState(() {
                                  _progress = value;
                                });
                              },
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Duration(seconds: (_progress * 273).toInt())
                                    .toString()
                                    .substring(3, 7),
                                style: MyStyles.songTitleDark,
                              ),
                              Text(
                                Duration(seconds: 273)
                                    .toString()
                                    .substring(3, 7),
                                style: MyStyles.songTitleDark,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2 * padding),
                  SizedBox(
                    height: _controlsH,
                    child: Center(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, top: 8, bottom: 8),
                              child: SvgPicture.asset(
                                'assets/svg/ic-shuffle.svg',
                                width: 20,
                              ),
                            ),
                          ),
                          Spacer(),
                          RotatedBox(
                            quarterTurns: 2,
                            child: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/svg/ic-forward.svg',
                                width: 28,
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isPlaying = !_isPlaying;
                              });
                            },
                            child: Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                  color: MyColors.colorPrimary,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: SvgPicture.asset(
                                  _isPlaying
                                      ? 'assets/svg/ic-pause.svg'
                                      : 'assets/svg/ic-play.svg',
                                  height: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/svg/ic-forward.svg',
                              width: 28,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 8, top: 8),
                              child: SvgPicture.asset(
                                'assets/svg/ic-repeat.svg',
                                width: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: padding),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class WaveFormTrackShape extends SliderTrackShape {
  List<int> samples = [
    // ...
    0, 0, 0, 2, 4, 6, 8, 7, 8, 9, 8, 7, 6, 4, 5, 6, 4, 2,
    0, 1, 2, 3, 5, 6, 8, 1, 2, 6, 3, 5, 1, 1, 2, 6, 9, 4,
    2, 3, 4, 2, 9, 5, 4, 2, 6, 9, 8, 7, 4, 5, 6, 3, 2, 1,
    0, 0, 2, 3, 5, 6, 8, 1, 2, 6, 3, 5, 1, 1, 2, 6, 9, 4,
    2, 3, 4, 2, 9, 5, 4, 2, 6, 8, 5, 4, 6, 3, 2, 1, 0, 0,
    2, 3, 4, 2, 9, 5, 4, 2, 6, 9, 8, 7, 4, 5, 6, 3, 2, 1,
    0, 0, 2, 3, 5, 6, 8, 1, 2, 6, 3, 5, 1, 1, 2, 6, 9, 4,
    2, 3, 4, 2, 9, 5, 4, 2, 6, 8, 5, 4, 6, 3, 2, 1, 0, 0,
  ];

  // normalized samples to (0 , 1) range
  List<double> norm;
  Paint activePaint;
  Paint inactivePaint;

  WaveFormTrackShape() {
    norm = _normalize(min: 0, max: 10);
  }

  List<double> _normalize({double min, double max}) {
    assert(max > min);
    List<double> norm = List.generate(samples.length, (index) => 0);
    double range = max - min;
    for (var i = 0; i < samples.length; ++i)
      norm[i] = (samples[i] - min) / range;
    return norm;
  }

  @override
  Rect getPreferredRect(
      {RenderBox parentBox,
      Offset offset = Offset.zero,
      SliderThemeData sliderTheme,
      bool isEnabled,
      bool isDiscrete}) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx + 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 4;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {RenderBox parentBox,
      SliderThemeData sliderTheme,
      Animation<double> enableAnimation,
      Offset thumbCenter,
      bool isEnabled,
      bool isDiscrete,
      TextDirection textDirection}) {
    Rect rect = getPreferredRect(
        parentBox: parentBox,
        offset: offset,
        sliderTheme: sliderTheme,
        isEnabled: isEnabled,
        isDiscrete: isDiscrete);

    final double strokeWidth = 2;
    final double padding = 1;

    final double halfHeight = rect.height / 2;
    final startX = rect.centerLeft.dx;
    final centerY = rect.top + halfHeight;

    if (activePaint == null)
      activePaint = Paint()
        ..color = sliderTheme.activeTrackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

    if (inactivePaint == null)
      inactivePaint = Paint()
        ..color = sliderTheme.inactiveTrackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

    Path activeWavePath = Path();
    Path inactiveWavePath = Path();

    // calculates max number of wave pulses that can be shown based on available width
    int maxIdx =
        min((rect.width / (strokeWidth + padding)).ceil(), norm.length - 1);

    int activeIdx =
        ((thumbCenter.dx - rect.centerLeft.dx) / rect.width * maxIdx).round();

    // active wave path
    for (var i = 0; i < activeIdx; ++i) {
      activeWavePath
        ..moveTo(startX + (i * (strokeWidth + padding)),
            centerY - norm[i] * halfHeight)
        ..lineTo(startX + (i * (strokeWidth + padding)),
            centerY + norm[i] * halfHeight);
    }

    // inactive wave path
    for (var i = activeIdx; i < maxIdx; ++i) {
      inactiveWavePath
        ..moveTo(startX + (i * (strokeWidth + padding)),
            centerY - norm[i] * halfHeight)
        ..lineTo(startX + (i * (strokeWidth + padding)),
            centerY + norm[i] * halfHeight);
    }

    context.canvas.drawPath(activeWavePath, activePaint);
    context.canvas.drawPath(inactiveWavePath, inactivePaint);
  }
}
