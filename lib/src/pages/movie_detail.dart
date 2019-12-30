import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieDetail extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[//esto es parecido al child
          _createAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 20.0),
                  _titlePoster(movie),
                  _description(movie),
                  

                ]

              ),
          )

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
          style: TextStyle(color: Colors.white, fontSize: 20.0),
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

Widget  _titlePoster(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(image: NetworkImage(movie.getPosterImg()), height: 150.0,
            ),
          ),
          SizedBox(width: 15.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 13.0, ), overflow: TextOverflow.ellipsis),
                SizedBox(height: 10.0,),
                Text(movie.originalTitle, style: TextStyle(color: Colors.white, fontSize: 10.0, ), overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border, color: Colors.white, size: 15.0,),
                    Text(movie.voteAverage.toString(), style: TextStyle(color: Colors.white, fontSize: 15.0, ), overflow: TextOverflow.ellipsis),
                  ],
                )


              ],
            ),
          )

        ],
      ),
    );

}

Widget  _description(Movie movie) {
    
    return Container(
      padding: EdgeInsets.all(20.0),

      child: Text(movie.overview, style: TextStyle(color: Colors.white, fontSize: 15.0, ), textAlign: TextAlign.justify,),

    );
}
}
