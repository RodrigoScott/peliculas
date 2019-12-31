
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/proviers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.black,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: theme.textTheme,
    );
  }

  String select = '';
  final movieProvider = new MoviesProvider();


  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appBar dentro de la caja de busqueda
    return [
      IconButton(

          icon: Icon(Icons.clear), 
          onPressed: (){
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
            ),
        onPressed: (){
          close(
              context,
              null,
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty){
      return Container();
    }
     return FutureBuilder(
          future: movieProvider.searchMovie(query),
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot)
      {
        if (snapshot.hasData) {

          final movies = snapshot.data;

            return ListView(
              children: movies.map((movie){
                return ListTile(

                  leading: FadeInImage(
                      placeholder: AssetImage('asset/img/no-image.jpg'),
                      image: NetworkImage(movie.getPosterImg()),
                      height: 250.0,
                      fit: BoxFit.cover,
                  ),
                  title: Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 13.0, ), overflow: TextOverflow.ellipsis),
                  subtitle: Text(movie.originalTitle, style: TextStyle(color: Colors.white, fontSize: 10.0, ), overflow: TextOverflow.ellipsis),
                  onTap: (){
                    close(context, null);
                    movie.uniqueId = '${movie.uniqueId}-search';
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                );
              }).toList()
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );

  }

  /*@override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.grey,
        child: Text(select),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias de resultados de la busqueda dependiendo de la escritura

    final suggestedList = (query.isEmpty) ? recentMovies : movies.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestedList.length,
      itemBuilder: (context,i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestedList[i]),
          onTap: (){
            select = suggestedList[i];
            showResults(context);
          },
        );
      },
    );
  }*/



}