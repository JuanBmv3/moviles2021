import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/profile_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperProfile{
  static final _nombreBD = "PROFILEBD";
  static final _versionBD = 1;
  static final _nombreTBL = "tblProfile";

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
    await db.execute("CREATE TABLE $_nombreTBL (id INTEGER PRIMARY KEY, nombre VARCHAR(50), a_paterno VARCHAR(100), a_materno VARCHAR(100), num_telf VARCHAR(100), correo VARCHAR(100), image VARCHAR(100)) ");
  }

  Future<int> insert(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.insert(_nombreTBL,row);
  }

  Future<int> update(Map<String, dynamic> row) async{
    var conexion = await database;
    var info = await conexion!.query(_nombreTBL);

    if(info.isEmpty) {
      return insert(row);
    } else{
      var newinfo = ProfileModel.fromMap(info.first);
      return conexion.update(_nombreTBL,row, where: 'id = 1',);
    }  
    
  }

  Future<ProfileModel> getProfile() async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    if(result.isNotEmpty){
      return  ProfileModel.fromMap(result.first);
    }else{
      return ProfileModel(
        nombre: 'Sin nombre',
        a_paterno: '',
        a_materno: '',
        num_tel: '',
        correo: '',
        image: '',
      );
    }
  }
}