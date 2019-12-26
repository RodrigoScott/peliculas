import 'package:flutter/material.dart';
import 'package:peliculas/src/proviers/peliculas_provider.dart';
import 'package:peliculas/src/widget/card_swiper_widget.dart';
import 'package:peliculas/src/widget/movie_horizontal.dart';


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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footer(context),

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

 Widget _footer(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subhead,),
          FutureBuilder(
              future: peliculasProvider.getPopular(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                //snapshot.data?.forEach((movie) => print(movie.title));
                if (snapshot.hasData){
                  return MovieHorizontal(movie: snapshot.data);
                }
                else{
                  CircularProgressIndicator();
                }
                return Container();
              },

          )

        ],
      ),
      width: double.infinity,
    );

 }
}