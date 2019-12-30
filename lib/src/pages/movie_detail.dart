import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieDetail extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[//esto es parecido al child
          _createAppBar(movie),

        ],
      )

    );
  }

 Widget  _createAppBar(Movie movie) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.grey,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
        background:
        FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('asset/img/loading.gif'),
          fadeInDuration: Duration(seconds: 2),
          fit: BoxFit.cover,

        ),

      ),


    );

 }
}
