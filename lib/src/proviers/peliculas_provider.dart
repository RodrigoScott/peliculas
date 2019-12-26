import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;



class PeliculasProvider {
  String _apikey = '509c6612a941d717cb26b72abc98b382';
  //1865f43a0549ca50d341dd9ab8b29f49
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

Future<List<Pelicula>>  getEnCines() async{

  final url = Uri.https(_url, '3/movie/now_playing', {

    'api_key' : _apikey,
    'language' : _language,

  });

  final resp = await http.get( url );
  final decodedData = json.decode(resp.body);

  final peliculas = new Peliculas.fromJsonList(decodedData['results']);
  
  print(peliculas.items[0].title);

  return peliculas.items;

  }

}