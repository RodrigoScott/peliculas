import 'package:flutter/material.dart';
import 'package:peliculas/src/proviers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widget/card_swiper_widget.dart';
import 'package:peliculas/src/widget/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: DataSearch(),
                    //query: 'Hola', //busqueda precargada
                );
              },

          )
        ],
      ),
      body:

      SafeArea( //para respetar el notch de los celulares mas nuevos
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
        future: peliculasProvider.getCinema(),
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

    peliculasProvider.getPopular();

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Container(
              padding: EdgeInsets.only(left: 20),
              child: Text('Populares', style: TextStyle(color: Colors.white))
          ),
          SizedBox(height: 10.0),
          StreamBuilder(
              stream: peliculasProvider.popularStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                //snapshot.data?.forEach((movie) => print(movie.title));
                if (snapshot.hasData){
                  return MovieHorizontal(movie: snapshot.data, nextPage: peliculasProvider.getPopular);
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }
                //return Container();
              },

          )

        ],
      ),

    );

 }
}