import 'package:flutter/material.dart';
import 'package:peliculas/src/proviers/peliculas_provider.dart';
import 'package:peliculas/src/widget/card_swiper_widget.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){}

          )
        ],
      ),
      body: SafeArea( //para respetar el notch de los celulares mas nuevos
          child: Column(
            children: <Widget>[
              _swiperTarjetas(),

            ],
          ),
      ),
    );
  }

 Widget _swiperTarjetas() {


    return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          if (snapshot.hasData) {
            return CardSwiper(peliculas: snapshot.data);
          }
          else{
            return Container(
              height: 400,
                child: Center(
                    child: CircularProgressIndicator()
                )
            );
          }
        },
    );

 }
}