import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/models/actors_model.dart';
import 'package:practica2/src/models/video_movie_model.dart';


class ApiVideo{

  Future<VideoMovieModel?> getVideo(id) async{
    var URL = Uri.parse('https://api.themoviedb.org/3/movie/${id}/videos?api_key=2bcfafdf5d88b4a662520ab59b675fba&language=en-US');
    final response = await http.get(URL);
    if(response.statusCode == 200){
      var popular = jsonDecode(response.body)['results'] as List;
     List<VideoMovieModel> listPopular = popular.map( (movie) => VideoMovieModel.fromMap(movie)).toList();
     return listPopular.first;
    }else{
      return null;
    }
  }
  
  Future<List<ActorsModel>?> getActors(id) async{
    
    var URL2 = Uri.parse('https://api.themoviedb.org/3/movie/${id}/credits?api_key=2bcfafdf5d88b4a662520ab59b675fba&language=en-US');
    final response = await http.get(URL2);
    
    if(response.statusCode == 200){
      var popular = jsonDecode(response.body)['cast'] as List;
     List<ActorsModel> listPopular = popular.map( (movie) => ActorsModel.fromMap(movie)).toList();
     return listPopular;
    }else{
      return null;
    }
  }
  
}