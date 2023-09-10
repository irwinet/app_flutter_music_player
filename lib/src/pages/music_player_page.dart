import 'package:animate_do/animate_do.dart';
import 'package:app_flutter_music_player/src/helpers/helpers.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/audioplayer_model.dart';
import '../widgets/custom_appbar.dart';


class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
            children: [
              CustomAppBar(),

              ImagenDiscoDuracion(),

              TituloPlay(),

              Expanded(
                child: Lyrics(),
              )
            ],
          ),
        ],
      ),
   );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff33333E),
            Color(0xff201E28),
          ]
        )
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return ListWheelScrollView(
      itemExtent: 42,
      diameterRatio: 1.5,
      physics: BouncingScrollPhysics(),
      children: lyrics.map((linea) => Text(linea, style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)),)).toList(),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 70),
      child: Row(
        children: [
          // TODO Disco
          ImagenDisco(),
          SizedBox(width: 100,),
          //TODO Barra progreso
          BarraProgreso(),
          SizedBox(width: 20,),
          
        ],
      ),
    );
  }
}

class TituloPlay extends StatefulWidget {
  const TituloPlay({
    super.key,
  });

  @override
  State<TituloPlay> createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin {

  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController playAnimation;
  final assetAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    playAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    this.playAnimation.dispose();
    super.dispose();
  }

  void open(){
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(
      Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
      autoStart: true,
      showNotification: true
    );
    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });
    assetAudioPlayer.current.listen((playingAudio) { 
      audioPlayerModel.songDuration = playingAudio?.audio.duration ?? Duration(seconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          Column(
            children: [
              Text('Far Away', style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.8)),),
              Text('-Breaking Benjamin-', style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5)),),
            ],
          ),

          Spacer(),

          FloatingActionButton(
            backgroundColor: Color(0xffF8CB51),
            elevation: 0,
            highlightElevation: 0,
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: playAnimation,
            ),
            onPressed: () {
              // TODO Boton
              final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);
              if(this.isPlaying){
                playAnimation.reverse();
                this.isPlaying = false;
                audioPlayerModel.controller.stop();
              }else{
                playAnimation.forward();
                this.isPlaying = true;
                audioPlayerModel.controller.repeat();
              }

              if(this.firstTime){
                this.open();
                this.firstTime=false;
              }
              else {
                assetAudioPlayer.playOrPause();
              }
            },
          )
        ],
      ),
    );
  }
}

class BarraProgreso extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(color: Colors.white.withOpacity(0.4));
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;
    return Container(
      child: Column(
        children: [
          Text('${audioPlayerModel.songTotalDuration}', style: estilo,),
          Stack(
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 230 * porcentaje,
                  color: Colors.white.withOpacity(0.8),
                ),
              )
            ],
          ),
          Text('${audioPlayerModel.currentSecond}', style: estilo,),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
              duration: Duration(seconds: 10),
              infinite: true,
              manualTrigger: true,
              controller: (animationController) => audioPlayerModel.controller = animationController,
              child: Image(image: AssetImage('assets/aurora.jpg'))
            ),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100)
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Color(0xff1C1C25),
                borderRadius: BorderRadius.circular(100)
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff484750),
            Color(0xff1E1C24),
          ]
        )
      ),
    );
  }
}