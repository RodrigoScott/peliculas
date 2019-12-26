import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> movie;

  MovieHorizontal({@required this.movie});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        children: _cards(),
      ),



    );
  }

List<Widget>_cards() {

    return movie.map((pelicula){

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            FadeInImage(
                placeholder: AssetImage('asset/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: 160.0,
            )
          ],
        ),

      );

    }).toList();
}
}
