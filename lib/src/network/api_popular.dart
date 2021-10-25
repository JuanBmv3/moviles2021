import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/models/popular_movies_model.dart';

class ApiPopular{

  var URL = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=2bcfafdf5d88b4a662520ab59b675fba&language=en-US&page=1');

  Future<List<PopularMoviesModel>?> getAllPopular() async{
    final response = await http.get(URL);
    if(response.statusCode == 200){
      var popular = jsonDecode(response.body)['results'] as List;
     List<PopularMoviesModel> listPopular = popular.map( (movie) => PopularMoviesModel.fromMap(movie)).toList();
     return listPopular;
    }else{
      return null;
    }
  }

  

  
}