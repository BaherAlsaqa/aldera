import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:aldera/constants/colors.dart';
import 'package:aldera/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

typedef void OnError(Exception exception);

class MessageCell extends StatefulWidget {
  final String /*user,*/ text, type;
  final bool mine;
  final String audioTime;
  final timestamp;
  // AudioPlayer audioPlayer;

  MessageCell(
      {Key key,
      /*this.user,*/
      this.text,
      this.type,
      this.mine,
        this.audioTime,
      this.timestamp,
      /*this.audioPlayer*/})
      : super(key: key);

  @override
  _MessageCellState createState() => _MessageCellState();
}

class _MessageCellState extends State<MessageCell> {
  //audio player
  Duration duration;
  Duration position;
  String localFilePath;
  // PlayerState playerState = PlayerState.stopped;

  // get isPlaying => playerState == PlayerState.playing;

  // get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';
  bool isMuted = false;
  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  String year, month, day, hour, min;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("widget.timestamp.toDate().toString() = "+
    //     widget.timestamp.toDate().toString()+ " || "+
    //     DateTime.parse(widget.timestamp.toDate().toString()).toString().split(" ")[0].split("-")[0]+" "+
    //     DateTime.parse(widget.timestamp.toDate().toString()).toString().split(" ")[0].split("-")[1]+" "
    //   +DateTime.parse(widget.timestamp.toDate().toString()).toString().split(" ")[0].split("-")[2]);
    // year = DateTime.parse(widget.timestamp.toDate().toString()).toString().split(" ")[0].split("-")[0];
    // month = DateTime.parse(widget.timestamp.toDate().toString()).toString().split(" ")[0].split("-")[1];
    // day = DateTime.parse(widget.timestamp.toDate().toString()).toString().split(" ")[0].split("-")[2];
    // hour = widget.timestamp.toDate().toString().split(" ")[1].split(".")[0].split(":")[0];
    // min = widget.timestamp.toDate().toString().split(" ")[1].split(".")[0].split(":")[1];
    // initAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    String networkImage = 'https://www.niemanlab.org/images/Greg-Emerson-edit-2.jpg';
    return Container(
      color: chatBackColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment:
              widget.mine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: <Widget>[
            /*Text(
              widget.user,
              style: TextStyle(
                color: widget.mine ? Colors.black : secandaryColor,
                fontSize: 13,
                fontFamily: 'Montserrat',
              ),
            ),*/
            Directionality(
              textDirection: widget.mine? ui.TextDirection.rtl: ui.TextDirection.ltr,
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(50.sp),
                        topEnd: Radius.circular(50.sp),
                        bottomStart: Radius.circular(50.sp),
                        bottomEnd: Radius.circular(50.sp)
                     ),
                      image: DecorationImage(
                        image: NetworkImage(
                          networkImage
                        )
                      ),
                      color: gray,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Container(
                    width: 284.w,
                    height: widget.type == TEXT? null: 70*3.w,
                    padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 12.0.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(widget.mine? 15: 15),
                        bottomLeft: Radius.circular(widget.mine? 15: 15),),
                      color: widget.mine ? primaryColor : gray4
                    ),
                    child: widget.type == TEXT
                        ? Text(
                            widget.text,
                            style: TextStyle(
                              color: widget.mine ? textWhite :
                              textGray3,
                              fontSize: 11.ssp,
                              fontFamily: PRIMARY_FONT_REGULAR,
                              height: 1.5.h
                            ),
                          )
                        : Container()/*Row(
                            children: [
                              Stack(
                                children: [
                                  isPlaying? CircularProgressIndicator(
                                    value: position != null && position.inMilliseconds > 0
                                        ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
                                        (duration?.inMilliseconds?.toDouble() ?? 0.0)
                                        : 0.0,
                                    valueColor: AlwaysStoppedAnimation(widget.mine?
                                        widget.themeProvider.style.primaryColor:
                                      widget.themeProvider.style.white),
                                    strokeWidth: 5.w,
                                    // backgroundColor: Colors.grey.shade400,
                                  ): isPaused?
                                  CircularProgressIndicator(
                                    value: position != null && position.inMilliseconds > 0
                                        ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
                                        (duration?.inMilliseconds?.toDouble() ?? 0.0)
                                        : 0.0,
                                    valueColor: AlwaysStoppedAnimation(widget.mine?
                                        widget.themeProvider.style.primaryColor:
                                      widget.themeProvider.style.white),
                                    strokeWidth: 5.w,
                                    // backgroundColor: Colors.grey.shade400,
                                  ):
                                  CircularProgressIndicator(
                                    value: 0.0,
                                    valueColor: AlwaysStoppedAnimation(widget.mine?
                                        widget.themeProvider.style.primaryColor:
                                      widget.themeProvider.style.white),
                                    strokeWidth: 5.w,
                                    // backgroundColor: Colors.grey.shade400,
                                  ),
                                  !isPlaying
                                      ? IconButton(
                                    onPressed: isPlaying ? null : () => play(),
                                    iconSize: 30.0*3.w,
                                    icon: Icon(Icons.play_arrow),
                                    color: widget.mine? widget.themeProvider.style.primaryColor:
                                    widget.themeProvider.style.white,
                                  )
                                      : IconButton(
                                    onPressed: isPlaying ? () => pause() : null,
                                    iconSize: 30.0*3.w,
                                    icon: Icon(Icons.pause),
                                    color: widget.mine? widget.themeProvider.style.primaryColor:
                                    widget.themeProvider.style.white,
                                  ),
                                ],
                                alignment: Alignment.center,
                              ),
                              isPlaying? _buildProgressView():
                                  isPaused? _buildProgressView():
                                _buildProgressView1(),
                            ],
                          )*/,
                  ),
                ],
              ),
            ),
            // DateTime.parse(widget.timestamp.toDate().toString()).toString()
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 50.w, end: 50.w, top: 8.h, bottom: 0.h
              ),
              child: Directionality(
                textDirection: widget.mine? ui.TextDirection.rtl: ui.TextDirection.ltr,
                child: Row(
                  children: [
                    Text('Nov 4, 18:03'
      /*DateFormat(
                          'dd MMMM y, m:h a',
                          Provider.of<LanguagesProvider>(context, listen: false)
                              .appLocal
                              .languageCode)
                          .format(DateTime(
                          int.parse(year),
                          int.parse(month),
                          int.parse(day),
                          int.parse(hour),
                          int.parse(min))) +
                          ", " +
                          widget.timestamp.toDate().toString().split(" ")[1].split(".")[0].substring(0, 5)*/,
                      style: TextStyle(
                        color: widget.mine ? gray : gray,
                        fontSize: 10.ssp,
                        fontFamily: PRIMARY_FONT_REGULAR,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Stack _buildProgressView() =>
  //     Stack(
  //       alignment: AlignmentDirectional.centerStart,
  //       children: [
  //         if (duration != null)
  //           SliderTheme(
  //             data: SliderTheme.of(context).copyWith(
  //               activeTrackColor: widget.mine?  widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white,
  //               inactiveTrackColor: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white,
  //               trackShape: RectangularSliderTrackShape(),
  //               trackHeight: 1.5*3.h,
  //               thumbColor: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white,
  //               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0*3.w),
  //               overlayColor: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white,
  //               overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0*3.w),
  //             ),
  //             child: Container(
  //               width: 250*3.w,
  //               child: Slider(
  //                   value:
  //                   position?.inMilliseconds?.toDouble() ?? 0.0,
  //                   onChanged: (double value) {
  //                     return widget.audioPlayer
  //                         .seek((value / 1000).roundToDouble());
  //                   },
  //                   min: 0.0,
  //                   max: duration.inMilliseconds.toDouble()),
  //             ),
  //           ),
  //         Padding(
  //           padding: EdgeInsetsDirectional.only(top: 100.h, start: 85.w),
  //           child: Text(
  //             position != null
  //                 ? "${positionText ?? ''} / ${durationText ?? ''}"
  //                 : duration != null
  //                 ? durationText
  //                 : '',
  //             style: TextStyle(
  //               fontSize: 12.0.ssp,
  //               fontFamily: PRIMARY_FONT_REGULAR,
  //               color: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white),
  //           ),
  //         )
  //       ],
  //     );
  // Stack _buildProgressView1() =>
  //     Stack(
  //       alignment: AlignmentDirectional.centerStart,
  //       children: [
  //           SliderTheme(
  //             data: SliderTheme.of(context).copyWith(
  //               activeTrackColor: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white,
  //               inactiveTrackColor: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white,
  //               trackShape: RectangularSliderTrackShape(),
  //               trackHeight: 1.5*3.h,
  //               thumbColor: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white,
  //               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0*3.w),
  //               overlayColor: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white,
  //               overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0*3.w),
  //             ),
  //             child: Container(
  //               width: 250*3.w,
  //               child: Slider(
  //                   value: 0.0,
  //                   onChanged: (double value) {
  //                   },
  //                   min: 0.0,
  //                   max: 0.0),
  //             ),
  //           ),
  //         Padding(
  //           padding: EdgeInsetsDirectional.only(top: 100.h, start: 85.w),
  //           child: Text(
  //             widget.audioTime,
  //             style: TextStyle(
  //               fontSize: 12.0.ssp,
  //               fontFamily: PRIMARY_FONT_REGULAR,
  //               color: widget.mine? widget.themeProvider.style.primaryColor:  widget.themeProvider.style.white),
  //             textDirection: ui.TextDirection.ltr,
  //           ),
  //         )
  //       ],
  //     );

  // Future play() async {
  //   if(!isPaused) stop();
  //   await widget.audioPlayer.play(widget.text);
  //   setState(() {
  //     playerState = PlayerState.playing;
  //   });
  // }

  // Future pause() async {
  //   await widget.audioPlayer.pause();
  //   setState(() => playerState = PlayerState.paused);
  // }

  // void initAudioPlayer() {
  //   _positionSubscription = widget.audioPlayer.onAudioPositionChanged
  //       .listen((p) => setState(() => position = p));
  //   _audioPlayerStateSubscription =
  //       widget.audioPlayer.onPlayerStateChanged.listen((s) {
  //     if (s == AudioPlayerState.PLAYING) {
  //       print("AudioPlayerState.PLAYING");
  //       setState(() => duration = widget.audioPlayer.duration);
  //     } else if (s == AudioPlayerState.STOPPED) {
  //       print("AudioPlayerState.STOPPED || position = "+position.toString()+" || duration = "+duration.toString());
  //       onComplete();
  //       setState(() {
  //         position = duration;
  //       });
  //     }else{
  //       // setState(() => duration = widget.audioPlayer.duration);
  //       print("AudioPlayerState.else");
  //     }
  //   }, onError: (msg) {
  //     setState(() {
  //       playerState = PlayerState.stopped;
  //       duration = Duration(seconds: 0);
  //       position = Duration(seconds: 0);
  //     });
  //   });
  // }
  //
  // Future _playLocal() async {
  //   await widget.audioPlayer.play(localFilePath, isLocal: true);
  //   setState(() => playerState = PlayerState.playing);
  // }
  //
  // Future stop() async {
  //   await widget.audioPlayer.stop();
  //   setState(() {
  //     playerState = PlayerState.stopped;
  //     position = Duration();
  //   });
  // }
  //
  // Future mute(bool muted) async {
  //   await widget.audioPlayer.mute(muted);
  //   setState(() {
  //     isMuted = muted;
  //   });
  // }
  //
  // void onComplete() {
  //   setState(() => playerState = PlayerState.stopped);
  // }

  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await http.readBytes(url);
    } on http.ClientException {
      rethrow;
    }
    return bytes;
  }

  // Future _loadFile() async {
  //   final bytes = await _loadFileBytes("kUrl",
  //       onError: (Exception exception) =>
  //           print('_loadFile => exception $exception'));
  //
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = io.File('${dir.path}/audio.mp3');
  //
  //   await file.writeAsBytes(bytes);
  //   if (await file.exists())
  //     setState(() {
  //       localFilePath = file.path;
  //     });
  // }

  @override
  void dispose() {
    // _positionSubscription.cancel();
    // _audioPlayerStateSubscription.cancel();
    // widget.audioPlayer.stop();
    super.dispose();
  }
}
