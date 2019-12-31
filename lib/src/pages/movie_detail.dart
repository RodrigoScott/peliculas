import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:peliculas/src/models/actors_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/proviers/peliculas_provider.dart';

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
                  _createCasting(movie),


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
      backgroundColor: Colors.black87,
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
          fadeInDuration: Duration(milliseconds: 200),
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
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(image: NetworkImage(movie.getPosterImg()), height: 150.0,
              ),
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

 Widget _createCasting(Movie movie) {

    final movieProvider = new MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _createActorPageVIew(snapshot.data);
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
   );

  }

  Widget _createActorPageVIew(List<Actor> actors) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actors.length,
        itemBuilder: (context, i) => _actorCard(actors[i]),

      ),
    );

  }

 Widget _actorCard(Actor actor) {

    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                placeholder: NetworkImage('https://www.mameau.com/game-history-notes/wiznliz/media/developers/no-avatar.jpg'),
                image: NetworkImage(actor.getPhoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,)
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
    );

 }


}
