import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper_movie.dart';
import 'package:practica2/src/models/favorite_movie_model.dart';

import 'package:practica2/src/utils/colors_movie_app.dart';

class ListaFavScreen extends StatefulWidget {
  ListaFavScreen({Key? key}) : super(key: key);

  @override
  _ListaFavScreenState createState() => _ListaFavScreenState();
}




class _ListaFavScreenState extends State<ListaFavScreen> {

  DatabaseHelperMovie? _databaseHelperMovie;

@override
  void initState() {
    // TODO: implement initState
     _databaseHelperMovie = DatabaseHelperMovie();
    super.initState();

  } 
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colores.mainColor,
      appBar: AppBar(
        title: Text('Favorite Movies'),
        backgroundColor: Colores.mainColor,
        centerTitle: true,
        
      ),
      body: FutureBuilder(
        future: _databaseHelperMovie!.getFavorites(),
        builder: (context, AsyncSnapshot<List<FavoriteMovieModel>?> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Hay un error en la petición'),);
              
            }else{
              if(snapshot.connectionState == ConnectionState.done){
                return _listFavoriteMovies(snapshot.data);
              }else{
                return CircularProgressIndicator();
                
              }
            }
        }
      ),
    );
  }

  Widget _listFavoriteMovies(List<FavoriteMovieModel>? movies) {
    return  ListView.separated(
        itemBuilder: (context,index){
          FavoriteMovieModel favorite = movies![index];
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
        child: Stack(
          alignment: Alignment.bottomCenter,
          children:[
            Container(
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'), 
                image: NetworkImage('https://image.tmdb.org/t/p/w500${favorite.image!}'),
                fadeInDuration: Duration(milliseconds: 500),
                fit: BoxFit.fill,
              )
            ),
            Opacity(
              opacity: .5,
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                height: 55.0,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(favorite.titulo!, style: TextStyle(color: Colors.white, fontSize:12.0)),
                   
                  ],
                )
              ),
            )
          ]
        ),
      ),
    );
          
        }, 
        separatorBuilder: (_,__) => Divider(height:10), 
        itemCount: movies!.length,
      );
  }
}
