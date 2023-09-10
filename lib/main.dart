import 'package:app_flutter_music_player/src/models/audioplayer_model.dart';
import 'package:app_flutter_music_player/src/pages/music_player_page.dart';
import 'package:app_flutter_music_player/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> new AudioPlayerModel())
      ],
      child: MaterialApp(
        title: 'Music Player',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: MusicPlayerPage()
      ),
    );
  }
}