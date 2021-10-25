import 'package:flutter/material.dart';

import 'package:practica2/src/database/database_helper_movie.dart';
import 'package:practica2/src/models/actors_model.dart';
import 'package:practica2/src/models/favorite_movie_model.dart';
import 'package:practica2/src/models/video_movie_model.dart';
import 'package:practica2/src/network/api_video.dart';
import 'package:practica2/src/utils/colors_movie_app.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';




class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  ApiVideo? apivideo;
  DatabaseHelperMovie? _databaseHelperMovie;
 
  Color colorfavorite = Colors.white;

@override
  void initState() {
    // TODO: implement initState
     _databaseHelperMovie = DatabaseHelperMovie();

    super.initState();
    apivideo = ApiVideo();
   
  } 
  
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    return Scaffold(
      backgroundColor: Colores.mainColor,
      appBar: AppBar(
        actions: [
          favoriteButton(),
        ],
        backgroundColor: Colores.mainColor,
        centerTitle: true,
      ),
      body:ListView(
        shrinkWrap: true,
        children: [
          VideoMovie(movie['id']),
          SizedBox(height: 10),
          InformacionMovie(movie['posterpath'],movie['title'], movie['voteaverage'],movie['id'] ),
          SizedBox(height: 10),
          DescMovie(movie['overview']),
          SizedBox(height: 15),
           Padding(
             padding: const EdgeInsets.only(left: 10, ),
             child: Text(
          'Actores', style: GoogleFonts.nunito( fontWeight: FontWeight.bold, color: Colors.orange[900], fontSize: 25,), ),
           ),
            SizedBox(height: 8.0),
          ActorsMovie(movie['id'])

        ]
      )
    );
  }

  Widget VideoMovie(id) {    
    return  FutureBuilder(
        future: apivideo!.getVideo(id),
        builder: (context, AsyncSnapshot<VideoMovieModel?> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Hay un error en la petición'),);
              
            }else{
              if(snapshot.connectionState == ConnectionState.done){
                final video = snapshot.data;

                YoutubePlayerController _controller = YoutubePlayerController(
                initialVideoId: video!.key == null ? 'wCtQJkHqCrM' : video.key!,
                flags: YoutubePlayerFlags(
                    enableCaption: false,
                    isLive: false,
                    autoPlay: true,
                    mute: false,
                    loop: true,
                  ),
                );
                
                return YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent ,

              );
                
              }else{
                return Container();
              }
            }
        }
      ); 
    
}

  Widget InformacionMovie(poster, title, votos, id) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
     
      children: [
         Padding(
           padding: const EdgeInsets.only(left: 8),
           child: ClipRRect(
              borderRadius:  BorderRadius.circular(10),
              child: Hero(
                tag: '${id}',
                child: Image(
                  
                  image: NetworkImage('https://image.tmdb.org/t/p/w500${poster}'),
                  height: 250,
                  fit: BoxFit.fill
                ),
              )
           ),
         ),
         SizedBox(width: 16.0),
         Expanded(
           child: Padding(
             padding: const EdgeInsets.only(right: 10, bottom: 50),
             child: Column(
               
               crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Center(child: Text("${title}", style:  GoogleFonts.nunito( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 21,), textAlign: TextAlign.center)),
                 SizedBox(height:10),
                 Center(
                   child: Row(
                     children: [
                       Text("Calificación", style:  GoogleFonts.nunito( fontWeight: FontWeight.bold, color: Colors.orange[900], fontSize: 20,), textAlign: TextAlign.center),
                       SizedBox(width:10),
                       Text(votos.toString(), style:  GoogleFonts.nunito( fontWeight: FontWeight.bold, color: Colors.orange[900], fontSize: 20,), textAlign: TextAlign.center)
                
                     ],
                   )
                 ),
                 Center(
                   child: Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(right: 8),
                         child: Text("Votos", style:  GoogleFonts.nunito( fontWeight: FontWeight.bold, color: Colors.orange[900], fontSize: 20,), textAlign: TextAlign.center),
                       ),
                      
                       RatingBar.builder(
                           ignoreGestures: true,
                           itemCount: 5,
                           itemSize: 20,
                           initialRating: votos/2,
                           allowHalfRating: true,
                           itemBuilder: (context,_){
                             return Icon(Icons.star, color: Colors.yellow,);
                           },
                           onRatingUpdate: (raiting){
                            print(raiting);
                           },
                       ),
                     ],
                   ),
                 )
               ],
             ),
           ),
         )
      ],
    );
  }

 Widget DescMovie(overview) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right:15),
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descripción', style: GoogleFonts.nunito( fontWeight: FontWeight.bold, color: Colors.orange[900], fontSize: 25,), textAlign: TextAlign.center),
                SizedBox(height: 8.0),
                Text(
                  overview, style: GoogleFonts.nunito( fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20 ), textAlign: TextAlign.justify) ,
              ],
            ),
    );
 }

 Widget ActorsMovie(id){
    return Container(
      height:350,
      child: FutureBuilder(
        future: apivideo!.getActors(id),
        builder: (context, AsyncSnapshot<List<ActorsModel>?> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Hay un error en la petición'),);
              
            }else{
              if(snapshot.connectionState == ConnectionState.done){

                final actors = snapshot.data!;
                return PageView.builder(
                  controller: PageController(viewportFraction: 0.55),
                  scrollDirection: Axis.horizontal,
                  itemCount: actors.length,
                  itemBuilder: (context, index){ 

                  ActorsModel actor = actors[index];
                    
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(children: [
                            CircleAvatar(
                              backgroundImage: actor.profilePath == null ? NetworkImage('https://www.tekcrispy.com/wp-content/uploads/2018/10/avatar.png') : NetworkImage('https://image.tmdb.org/t/p/w500${actor.profilePath}'),
                              radius:  80,
                              backgroundColor: Colors.transparent,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('${actor.name}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:  23,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),),
                            ),  
                          ],),
                        ),
                      
                    );
                  },
                );
                
                
              }else{
                return Container();
                
              }
            }
        }
      )

      
    );
  }

 
}

class favoriteButton extends StatefulWidget {
  favoriteButton({Key? key,}) : super(key: key);

  @override
  _favoriteButtonState createState() => _favoriteButtonState();
}

class _favoriteButtonState extends State<favoriteButton> {
   bool isfavorite = false;
    DatabaseHelperMovie? _databaseHelperMovie;
    @override
  void initState() {
    // TODO: implement initState
     _databaseHelperMovie = DatabaseHelperMovie();

    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
   final movie = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;


   final id = movie['id'];
   final title = movie['title'];
   final backdropPath = movie['backdropPath'];
    return FutureBuilder(
      future: _databaseHelperMovie?.isFavorite(movie['id']),
      builder: (context,AsyncSnapshot<FavoriteMovieModel?> snapshot){
      if(snapshot.hasError){
        return Center(child: Text("Ocurrio un error en la peticion"),);
      }else{
        if(snapshot.connectionState == ConnectionState.done){
             final movieFavorite = snapshot.data;
             if(movieFavorite == null){
               isfavorite = true;
             }
             return IconButton(
                icon: isfavorite == true ? Icon(Icons.favorite, color: Colors.white): Icon(Icons.favorite, color: Colors.red),
                
                onPressed: (){
                  if(isfavorite){
                    FavoriteMovieModel movie =  FavoriteMovieModel(
                        movieKey: id,
                        titulo: title,
                        image: backdropPath,
                      );
                      _databaseHelperMovie?.insert(movie.toMap()).then(
                        (value){
                          if(value > 0){
                            setState(() {
                              isfavorite = !isfavorite;
                            });
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('La solicitud no se completo'))
                            );
                          }
                        }
                      );
                  }else{
                    _databaseHelperMovie?.delete(id).then((noRows){
                          if(noRows > 0){
                            setState(() {
                              isfavorite = !isfavorite;
                            });           
                          }
                        });
                  }
                },
                iconSize: 35,
             );
        }else{
          return Container();
           
        }
      }
      }
    ); 
  }
}
