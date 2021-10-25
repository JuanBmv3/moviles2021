import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/favorite_movie_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperMovie{
  static final _nombreBD = "MOVIESBD";
  static final _versionBD = 1;
  static final _nombreTBL = "tblMovies";

  static Database? _database;

  Future<Database?> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path,_nombreBD); 
    return openDatabase(
      rutaBD,
      version: _versionBD,
      onCreate: _crearTabla,
      
    );
  }

  Future<void> _crearTabla(Database db, int version) async {
    await db.execute("CREATE TABLE $_nombreTBL (id INTEGER PRIMARY KEY, movieKey INT , titulo VARCHAR(100), image VARCHAR(200))");
  }

  Future<int> insert(Map<String, dynamic> row) async{
    var conexion = await database;
   
    return conexion!.insert(_nombreTBL,row);
  }


  Future<int> delete(int id ) async{
    var conexion = await database;
    return await conexion!.delete(_nombreTBL,where: 'movieKey = ? ', whereArgs: [id]);

  }

  Future<List<FavoriteMovieModel>> getFavorites() async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
   return result.map((movieMap) => FavoriteMovieModel.fromMap(movieMap)).toList();
  }

  Future<FavoriteMovieModel?> isFavorite(int id) async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL, where: 'movieKey= ?', whereArgs: [id]);
    if(result.isEmpty){
      return null;
    }else{
      return FavoriteMovieModel.fromMap(result.first);
    }
  }
  

}