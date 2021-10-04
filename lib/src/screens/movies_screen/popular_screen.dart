import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
class PopupalScreen extends StatefulWidget {
  PopupalScreen({Key? key}) : super(key: key);

  @override
  _PopupalScreenState createState() => _PopupalScreenState();
}

class _PopupalScreenState extends State<PopupalScreen> {
 
 ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
  } 
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiPopular!.getAllPopular(),
      builder: (context, AsyncSnapshot<List<PopularMoviesModel>?> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text('Hay un error en la petición'),);
            
          }else{
            if(snapshot.connectionState == ConnectionState.done){
              return _listPopularMovies(snapshot.data);
            }else{
              return CircularProgressIndicator();
              
            }
          }
      }
    );
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? movies) {
    return  ListView.separated(
        itemBuilder: (context,index){
          PopularMoviesModel popular = movies![index];
         return CardPopularView(
            popular
          );
        }, 
        separatorBuilder: (_,__) => Divider(height:10), 
        itemCount: movies!.length,
      );
  }

  Widget CardPopularView(PopularMoviesModel popular) {
    return Scaffold();
  }
}