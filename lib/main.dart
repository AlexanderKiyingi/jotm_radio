import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:jotm_radio/common.dart';
import 'package:jotm_radio/theme.dart'; // Ensure this is importing the correct theme file
import 'package:jotm_radio/app_state.dart'; // Import your state class
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Use the correct path to the SocialmediaWidget file

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  // runApp(const MyApp());
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}


class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _player = AudioPlayer();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    // Configure audio session
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    // Listen to errors during playback
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      // print('A stream error occurred: $e');
    });

    // Load audio from a source and handle errors
    try {
      await _player.setAudioSource(AudioSource.uri(
        Uri.parse("https://edge.mixlr.com/channel/mjdyi"),
        tag: MediaItem(
          id: '1',
          album: "JOTM Radio",
          title: "Jazz On The Move",
          artUri: Uri.parse('https://example.com/albumart.jpg'),
        ),
      ));
    } on PlayerException {
      // print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Do not stop the player, allow background playback
      // _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget flutterFlowIconButton({
    required BuildContext context,
    required double buttonSize,
    required IconData icon, // IconData expected here, not a widget
    required double iconSize,
    required VoidCallback onPressed,
    Color? borderColor, // Optional border color, defaults to theme-based color
    double borderWidth = 1.0, // Default values
    double borderRadius = 20.0, // Default values
    Color? iconColor, // Optional icon color, defaults to theme-based color
  }) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ??
              AppTheme.secondaryBackgroundColor, // Default to theme color
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: IconButton(
        icon: FaIcon(
          icon, // Using IconData here
          color: iconColor ?? AppTheme.info, // Default to theme color
          size: iconSize,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          minWidth: buttonSize,
          minHeight: buttonSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme, // Apply the custom theme
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.primaryBackgroundColor,
        // appBar: AppBar(
        //   backgroundColor: AppTheme.warning,
        //   automaticallyImplyLeading: false,
        //   title: Text(
        //     'Jazz On The Move',
        //     style: AppTheme.headline1.copyWith(color: Colors.white),
        //   ),
        //   centerTitle: false,
        //   elevation: 2.0,
        // ),
        drawer: Drawer(
          elevation: 16,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.secondaryTextColor,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 40, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                width: 300,
                                height: 300,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/images/1JOTM_LOGO_GOLD.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 2, 0, 0),
                              child: Text(
                                'Jazz On the move',
                                style: AppTheme.bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: AppTheme.primaryBackgroundColor,
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 10),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _launchURL(
                                        'https://docs.google.com/document/d/1uE2JW7P9D8dKA-eYIViwbWjziDlT7D7orXHzh1CWvP0/edit?usp=sharing');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                            child: Icon(
                                              Icons.security_outlined,
                                              color: AppTheme
                                                  .secondaryBackgroundColor,
                                              size: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 5, 0),
                                            child: Text(
                                              'Privacy Policy',
                                              style:
                                                  AppTheme.bodyMedium.override(
                                                fontFamily: 'Readex Pro',
                                                color: AppTheme
                                                    .secondaryBackgroundColor,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: AppTheme.primaryBackgroundColor,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                indent: 30,
                                color: AppTheme.alternate,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _launchURL('https://docs.google.com/document/d/1cPl2fQ5DWf_T8ZOejVdwxtspwLt67kZshf3guzFIVwo/edit?usp=sharing');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                            child: Icon(
                                              Icons.document_scanner,
                                              color: AppTheme
                                                  .secondaryBackgroundColor,
                                              size: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 5, 0),
                                            child: Text(
                                              'User Agreement',
                                              style:
                                                  AppTheme.bodyMedium.override(
                                                fontFamily: 'Readex Pro',
                                                color: AppTheme
                                                    .secondaryBackgroundColor,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: AppTheme.primaryBackgroundColor,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                indent: 30,
                                color: AppTheme.alternate,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _launchURL('https://jazzonthemove.co/');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 8, 0),
                                            child: FaIcon(
                                              FontAwesomeIcons.internetExplorer,
                                              color: AppTheme
                                                  .secondaryBackgroundColor,
                                              size: 18,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 5, 0),
                                            child: Text(
                                              'Visit our website',
                                              style:
                                                  AppTheme.bodyMedium.override(
                                                fontFamily: 'Readex Pro',
                                                color: AppTheme
                                                    .secondaryBackgroundColor,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: AppTheme.primaryBackgroundColor,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                indent: 30,
                                color: AppTheme.alternate,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.secondaryTextColor,
                          AppTheme.primaryTextColor
                        ],
                        stops: [0.0, 0.5],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 10.0, 16.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding:
                              //       EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                // child: Row(
                                //   mainAxisSize: MainAxisSize.max,
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                  // children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppTheme.secondaryTextColor,
                                          ),
                                        ),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/1JOTM_LOGO_GOLD.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    flutterFlowIconButton(
                                      context: context,
                                      borderRadius: 8,
                                      buttonSize: 40,
                                      icon: Icons.settings_outlined,
                                      // iconColor: AppTheme.of(context).info,
                                      iconSize: 24,
                                      iconColor:
                                          AppTheme.secondaryBackgroundColor,
                                      onPressed: () async {
                                        scaffoldKey.currentState!.openDrawer();
                                      },
                                    ),
                                  // ],
                                // ),
                              // ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: SafeArea(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  40.0, 10.0, 40.0, 10.0),
                              child: Container(
                                width: 400.0,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryBackgroundColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    'https://neurosciencenews.com/files/2023/09/love-song-recognition-neurosicnes.jpg',
                                    width: 300.0,
                                    height: 400.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 20.0, 16.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Jazz On The Move',
                                style: AppTheme.bodyText1.copyWith(
                                  color: AppTheme.secondaryBackgroundColor,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ControlButtons(_player),
                        StreamBuilder<PositionData>(
                          stream: _positionDataStream,
                          builder: (context, snapshot) {
                            final positionData = snapshot.data;
                            return SeekBar(
                              duration: positionData?.duration ?? Duration.zero,
                              position: positionData?.position ?? Duration.zero,
                              bufferedPosition:
                                  positionData?.bufferedPosition ??
                                      Duration.zero,
                              onChangeEnd: _player.seek,
                            );
                          },
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 1),
                                    child: Text(
                                      'Follow us on',
                                      style: AppTheme.bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            AppTheme.secondaryBackgroundColor,
                                        fontSize: 12,
                                        letterSpacing: 0.0,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3, 3, 3, 3),
                                        child: flutterFlowIconButton(
                                          context: context,
                                          borderColor:
                                              AppTheme.secondaryBackgroundColor,
                                          borderRadius: 20,
                                          borderWidth: 1,
                                          buttonSize: 35,
                                          icon: FontAwesomeIcons.instagram,
                                          iconSize: 16,
                                          iconColor:
                                              AppTheme.secondaryBackgroundColor,
                                          onPressed: () async {
                                            _launchURL(
                                                'https://www.instagram.com/jazzonthemove_radio?igsh=anE5cWMxN3BnajE5&utm_source=qr');
                                          },
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsetsDirectional.fromSTEB(
                                      //       3, 3, 3, 3),
                                      //   child: flutterFlowIconButton(
                                      //     context: context,
                                      //     borderColor:
                                      //         AppTheme.secondaryBackgroundColor,
                                      //     borderRadius: 20,
                                      //     borderWidth: 1,
                                      //     buttonSize: 35,
                                      //     icon: Icons.tiktok_rounded,
                                      //     iconSize: 19,
                                      //     iconColor:
                                      //         AppTheme.secondaryBackgroundColor,
                                      //     onPressed: () async {
                                      //       _launchURL('#');
                                      //     },
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3, 3, 3, 3),
                                        child: flutterFlowIconButton(
                                          context: context,
                                          borderColor:
                                              AppTheme.secondaryBackgroundColor,
                                          borderRadius: 20,
                                          borderWidth: 1,
                                          buttonSize: 35,
                                          icon: FontAwesomeIcons.twitter,
                                          iconSize: 19,
                                          onPressed: () async {
                                            _launchURL(
                                                'https://x.com/jazzonthemove/status/1831778907173097686?s=46&t=zBneDp1glS1D2GHpnVTc-g');
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(3, 3, 3, 3),
                                        child: flutterFlowIconButton(
                                          context: context,
                                          borderColor:
                                              AppTheme.secondaryBackgroundColor,
                                          borderRadius: 20,
                                          borderWidth: 1,
                                          buttonSize: 35,
                                          icon: FontAwesomeIcons.youtube,
                                          iconSize: 16,
                                          iconColor:
                                              AppTheme.secondaryBackgroundColor,
                                          onPressed: () async {
                                            _launchURL(
                                                'https://www.youtube.com/@jazzonthemove');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Send audionote',
                                    style: AppTheme.bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      color: AppTheme.secondaryBackgroundColor,
                                      fontSize: 12,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 2, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _launchURL(
                                              'https://www.speakpipe.com/jazzonthemove');
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            flutterFlowIconButton(
                                              context: context,
                                              borderRadius: 20,
                                              borderWidth: 1,
                                              buttonSize: 40,
                                              icon: Icons.mic_none_rounded,
                                              iconSize: 24,
                                              iconColor: AppTheme
                                                  .secondaryBackgroundColor,
                                              onPressed: () async {
                                                _launchURL(
                                                    'https://www.speakpipe.com/jazzonthemove');
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
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
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up),
          color: AppTheme.secondaryBackgroundColor,
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                color: AppTheme.secondaryBackgroundColor,
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                color: AppTheme.secondaryBackgroundColor,
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                color: AppTheme.secondaryBackgroundColor,
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text(
              "${snapshot.data?.toStringAsFixed(1)}x",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            color: AppTheme.secondaryBackgroundColor,
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}




// back up
// import 'package:audio_session/audio_session.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import 'package:jotm_radio/common.dart';
// import 'package:jotm_radio/theme.dart'; // Ensure this is importing the correct theme file
// import 'package:jotm_radio/app_state.dart'; // Import your state class
// import 'package:rxdart/rxdart.dart';
// import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package
// import 'package:provider/provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:jotm_radio/socialmedia_widget.dart';  // Use the correct path to the SocialmediaWidget file




// Future<void> main() async {
//   await JustAudioBackground.init(
//     androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
//     androidNotificationChannelName: 'Audio playback',
//     androidNotificationOngoing: true,
//   );

//   // runApp(const MyApp());
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => AppState(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   MyAppState createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   final _player = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     ambiguate(WidgetsBinding.instance)!.addObserver(this);
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.black,
//     ));
//     _init();
//   }

//   Future<void> _init() async {
//     // Configure audio session
//     final session = await AudioSession.instance;
//     await session.configure(const AudioSessionConfiguration.speech());

//     // Listen to errors during playback
//     _player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
//       // print('A stream error occurred: $e');
//     });

//     // Load audio from a source and handle errors
//     try {
//       await _player.setAudioSource(AudioSource.uri(
//         Uri.parse("https://edge.mixlr.com/channel/mjdyi"),
//         tag: MediaItem(
//           id: '1',
//           album: "JOTM Radio",
//           title: "Jazz On The Move",
//           artUri: Uri.parse('https://example.com/albumart.jpg'),
//         ),
//       ));
      
//     } on PlayerException {
//       // print("Error loading audio source: $e");
//     }
//   }

//   @override
//   void dispose() {
//     ambiguate(WidgetsBinding.instance)!.removeObserver(this);
//     _player.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       // Do not stop the player, allow background playback
//       // _player.stop();
//     }
//   }

//   Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
//     _player.positionStream,
//     _player.bufferedPositionStream,
//     _player.durationStream,
//     (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
//   );

//   Future<void> _launchURL(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: appTheme, // Apply the custom theme
//       home: Scaffold(
//         backgroundColor: AppTheme.primaryBackgroundColor,
//         appBar: AppBar(
//           backgroundColor: AppTheme.warning,
//           automaticallyImplyLeading: false,
//           title: Text(
//             'Jazz On The Move',
//             style: AppTheme.headline1.copyWith(color: Colors.white),
//           ),
//           centerTitle: false,
//           elevation: 2.0,
//         ),
//         body: SafeArea(
//           top:true,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Flexible(
//                 child: SafeArea(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppTheme.secondaryTextColor,
//                           AppTheme.primaryTextColor
//                         ],
//                         stops: [0.0, 0.5],
//                         begin: AlignmentDirectional(0.0, -1.0),
//                         end: AlignmentDirectional(0, 1.0),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 10.0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 100.0,
//                                 height: 40.0,
//                                 decoration: const BoxDecoration(),
//                                 child: Visibility(
//                                   visible: AppState().radioIsLive,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       IconButton(
//                                         icon: FaIcon(
//                                           FontAwesomeIcons.recordVinyl,
//                                           color: Theme.of(context).colorScheme.error, // Use your theme's error color
//                                           size: 24.0,
//                                         ),
//                                         onPressed: () {
//                                           // print('IconButton pressed ...');
//                                         },
//                                         style: ButtonStyle(
//                                           shape: WidgetStateProperty.all(RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(20.0),
//                                           )),
//                                           side: WidgetStateProperty.all(const BorderSide(
//                                             color:  AppTheme.secondaryBackgroundColor,
//                                             width: 1.0,
//                                           )),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 0.0, 0.0),
//                                         child: Text(
//                                           'Live',
//                                           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                             fontFamily: 'Readex Pro',
//                                             color:  AppTheme.secondaryBackgroundColor,
//                                             letterSpacing: 0.0,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton.icon(
//                                onPressed: () async {
//                                   await showModalBottomSheet(
//                                     isScrollControlled: true,
//                                     backgroundColor: Colors.transparent,
//                                     useSafeArea: true,
//                                     context: context,
//                                     builder: (context) {
//                                       return GestureDetector(
//                                         onTap: () => FocusScope.of(context).unfocus(),
//                                         child: Padding(
//                                           padding: MediaQuery.viewInsetsOf(context),
//                                           child: const SocialmediaWidget(),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                   // Update state after the modal is dismissed
//                                   context.read<AppState>().toggleRadioLive();
//                                 },                             
//                                 icon: const FaIcon(
//                                   FontAwesomeIcons.userPlus,
//                                   size: 16.0,
//                                 ),
//                                 label: Text(
//                                   'Follow',
//                                   style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                                     fontFamily: 'Readex Pro',
//                                     color: Colors.white,
//                                     letterSpacing: 0.0,
//                                   ),
//                                 ),
//                                 style: ButtonStyle(
//                                   backgroundColor: WidgetStateProperty.all(Colors.transparent),
//                                   padding: WidgetStateProperty.all(const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0)),
//                                   elevation:WidgetStateProperty.all(3.0),
//                                   shape: WidgetStateProperty.all(RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                     side: const BorderSide(
//                                       color:  AppTheme.secondaryBackgroundColor,
//                                       width: 1.0,
//                                     ),
//                                   )),
//                                 ),
//                               )
//                               // ).animateOnPageLoad(
//                               //     animationsMap['buttonOnPageLoadAnimation']!), // Ensure `animateOnPageLoad` is defined in your project
//                             ],
//                           ),
//                         ),
//                         Flexible(
//                           child: SafeArea(
//                             child: Padding(
//                               padding: const EdgeInsetsDirectional.fromSTEB(40.0, 10.0, 40.0, 10.0),
//                               child: Container(
//                                 width: 400.0,
//                                 height: 380.0,
//                                 decoration: BoxDecoration(
//                                   color: AppTheme.secondaryBackgroundColor,
//                                   borderRadius: BorderRadius.circular(20.0),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                   child: Image.network(
//                                     'https://neurosciencenews.com/files/2023/09/love-song-recognition-neurosicnes.jpg',
//                                     width: 300.0,
//                                     height: 400.0,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 16.0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Jazz On The Move',
//                                 style: AppTheme.bodyText1.copyWith(
//                                   color: AppTheme.primaryTextColor,
//                                   letterSpacing: 0.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),  
//                         ControlButtons(_player),
//                         StreamBuilder<PositionData>(
//                           stream: _positionDataStream,
//                           builder: (context, snapshot) {
//                             final positionData = snapshot.data;
//                             return SeekBar(
//                               duration: positionData?.duration ?? Duration.zero,
//                               position: positionData?.position ?? Duration.zero,
//                               bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
//                               onChangeEnd: _player.seek,
//                             );
//                           },
//                         ),
//                         Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 decoration: const BoxDecoration(),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.share,
//                                         color: AppTheme.secondaryBackgroundColor,
//                                         size: 24.0,
//                                       ),
//                                       onPressed: () {
//                                         // print('Share button pressed.');
//                                       },
//                                     ),
//                                     Text(
//                                       'Share',
//                                       style: AppTheme.bodyText1.copyWith(
//                                         color: AppTheme.secondaryBackgroundColor,
//                                         letterSpacing: 0.0,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 decoration: const BoxDecoration(),
//                                 child: InkWell(
//                                   splashColor: Colors.blueAccent,
//                                   focusColor: Colors.transparent,
//                                   hoverColor: Colors.transparent,
//                                   highlightColor: Colors.transparent,
//                                   onTap: () async {
//                                     await _launchURL('https://www.speakpipe.com/jazzonthemove');
//                                   },
//                                   // onTap: () async {
//                                   //   unawaited(
//                                   //     () async {
//                                   //       await _launchURL('https://www.speakpipe.com/jazzonthemove');
//                                   //     }(),
//                                   //   );
//                                   // },
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       IconButton(
//                                         icon: const Icon(
//                                           Icons.mic_none_rounded,
//                                           color: AppTheme.secondaryColor,
//                                           size: 24.0,
//                                         ),
//                                         onPressed: () {
//                                           // print('Mic button pressed.');
//                                         },
//                                       ),
//                                       Text(
//                                         'REC',
//                                         style: AppTheme.bodyText1.copyWith(
//                                           color: AppTheme.secondaryBackgroundColor,
//                                           letterSpacing: 0.0,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ]
//                     ),
//                   ),
//                 )
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ControlButtons extends StatelessWidget {
//   final AudioPlayer player;

//   const ControlButtons(this.player, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.volume_up),
//           color:AppTheme.secondaryBackgroundColor,
//           onPressed: () {
//             showSliderDialog(
//               context: context,
//               title: "Adjust volume",
//               divisions: 10,
//               min: 0.0,
//               max: 1.0,
//               value: player.volume,
//               stream: player.volumeStream,
//               onChanged: player.setVolume,
//             );
//           },
//         ),
//         StreamBuilder<PlayerState>(
//           stream: player.playerStateStream,
//           builder: (context, snapshot) {
//             final playerState = snapshot.data;
//             final processingState = playerState?.processingState;
//             final playing = playerState?.playing;
//             if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
//               return Container(
//                 margin: const EdgeInsets.all(8.0),
//                 width: 64.0,
//                 height: 64.0,
//                 child: const CircularProgressIndicator(),
//               );
//             } else if (playing != true) {
//               return IconButton(
//                 icon: const Icon(Icons.play_arrow),
//                 color:AppTheme.secondaryBackgroundColor,
//                 iconSize: 64.0,
//                 onPressed: player.play,
//               );
//             } else if (processingState != ProcessingState.completed) {
//               return IconButton(
//                 icon: const Icon(Icons.pause),
//                 color:AppTheme.secondaryBackgroundColor,
//                 iconSize: 64.0,
//                 onPressed: player.pause,
//               );
//             } else {
//               return IconButton(
//                 icon: const Icon(Icons.replay),
//                 color:AppTheme.secondaryBackgroundColor,
//                 iconSize: 64.0,
//                 onPressed: () => player.seek(Duration.zero),
//               );
//             }
//           },
//         ),
//         StreamBuilder<double>(
//           stream: player.speedStream,
//           builder: (context, snapshot) => IconButton(
//             icon: Text(
//               "${snapshot.data?.toStringAsFixed(1)}x",
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             color:AppTheme.secondaryBackgroundColor,
//             onPressed: () {
//               showSliderDialog(
//                 context: context,
//                 title: "Adjust speed",
//                 divisions: 10,
//                 min: 0.5,
//                 max: 1.5,
//                 value: player.speed,
//                 stream: player.speedStream,
//                 onChanged: player.setSpeed,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class PositionData {
//   final Duration position;
//   final Duration bufferedPosition;
//   final Duration duration;

//   PositionData(this.position, this.bufferedPosition, this.duration);
// }