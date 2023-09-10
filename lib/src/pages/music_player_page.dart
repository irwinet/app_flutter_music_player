import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';


class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),

          ImagenDiscoDuracion(),

          TituloPlay()
        ],
      ),
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
          SizedBox(width: 40,),
          //TODO Barra progreso
          BarraProgreso(),
          SizedBox(width: 20,),
          
        ],
      ),
    );
  }
}

class TituloPlay extends StatelessWidget {
  const TituloPlay({
    super.key,
  });

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
            onPressed: () {
              // TODO Boton
            },
            child: Icon(Icons.play_arrow),
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
    return Container(
      child: Column(
        children: [
          Text('00:00', style: estilo,),
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
                  height: 100,
                  color: Colors.white.withOpacity(0.8),
                ),
              )
            ],
          ),
          Text('00:00', style: estilo,),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(image: AssetImage('assets/aurora.jpg')),
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