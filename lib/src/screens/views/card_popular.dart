import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movies_model.dart';

class CardPopularView extends StatelessWidget{
  
  const CardPopularView({Key? key, required this.popular }) : super(key: key);
  final PopularMoviesModel popular;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0.0,5.0),
            blurRadius: 2.5
          )
        ]
      ) ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'), 
            image: NetworkImage('https://image.tmdb.org/t/p/w500${popular.backdropPath}'),
            fadeInDuration: Duration(milliseconds: 500),
            fit: BoxFit.fill,
          )
        ),
      ),
    );

  }
}