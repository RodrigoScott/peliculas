import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = '509c6612a941d717cb26b72abc98b382';
  //1865f43a0549ca50d341dd9ab8b29f49
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

 Future<List<Movie>> _ResponseProcess(Uri  url) async {

   final resp = await http.get( url );
   final decodedData = json.decode(resp.body);

   final peliculas = new Movies.fromJsonList(decodedData['results']);

   return peliculas.items;

 }

Future<List<Movie>>  getCinema() async{

  final url = Uri.https(_url, '3/movie/now_playing', {

    'api_key' : _apikey,
    'language' : _language,

  });

  return await _ResponseProcess(url);

  }


  Future<List<Movie>>  getPopular() async{

    final url = Uri.https(_url, '3/movie/now_playing', {

      'api_key' : _apikey,
      'language' : _language,

    });

    return await _ResponseProcess(url);

  }

}