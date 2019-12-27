import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> movie;

  MovieHorizontal({@required this.movie});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.27,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _cards(context),
      ),



    );
  }

List<Widget>_cards(BuildContext context) {

    return movie.map((pelicula){

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: AssetImage('asset/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white), textScaleFactor: 0.7,
            ),
          ],
        ),

      );

    }).toList();
}
}
