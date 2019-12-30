import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movie;
  final Function nextPage;

  MovieHorizontal({@required this.movie, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.27,
      child: PageView.builder(
        pageSnapping: false, //para que no regrese el carrusel sino que tome el flujo de movimiento
        controller: _pageController,
        //children: _cards(context),
        itemCount: movie.length,
        itemBuilder: ( context, i){
          return _cardCreate(context, movie[i]);
    
        },
      ),
    );
  }

Widget _cardCreate(BuildContext context, Movie pelicula){

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
