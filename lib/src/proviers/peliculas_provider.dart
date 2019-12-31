import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actors_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {

  String _apikey    = '509c6612a941d717cb26b72abc98b382';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';

  int _popularPage  = 0;

  bool _loading     = false;

  //create stream variables
  List<Movie> _populars = new List();

  final _popularStremController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>)get popularSink => _popularStremController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStremController.stream;

  void disposeStreams(){
    _popularStremController?.close();
  }




 Future<List<Movie>> _responseProcess(Uri  url) async {

   final resp = await http.get( url );
   final decodedData = json.decode(resp.body);

   final peliculas = new Movies.fromJsonList(decodedData['results']);

   return peliculas.items;

 }

Future<List<Movie>>  getCinema() async{

  final url = Uri.https(_url, '3/movie/now_playing', {

    'api_key'  : _apikey,
    'language' : _language,

  });

  return await _responseProcess(url);

  }


  Future<List<Movie>>  getPopular() async{

    if (_loading) return[];

    _loading = true;

   _popularPage++;

    final url = Uri.https(_url, '3/movie/now_playing', {

      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularPage.toString(),

    });

    final resp = await _responseProcess(url);

    _populars.addAll(resp);
    popularSink(_populars);

    _loading = false;

    return resp;

  }

  Future<List<Actor>> getCast(String movieId) async{
    final url = Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key'  : _apikey,
      'language' : _language,
    });
    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }

  Future<List<Movie>>  searchMovie(String query) async{

    final url = Uri.https(_url, '3/search/movie', {

      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query,

    });

    return await _responseProcess(url);

  }

}