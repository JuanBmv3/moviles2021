import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static final _nombreBD = "NOTASBD";
  static final _versionBD = 1;
  static final _nombreTBL = "tblNotas";

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
    await db.execute("CREATE TABLE $_nombreTBL (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100)) ");
  }

  Future<int> insert(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.insert(_nombreTBL,row);
  }

  Future<int> update(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.update(_nombreTBL,row, where: 'id = ?', whereArgs:[row['id']] );

  }

  Future<int> delete(int id ) async{
    var conexion = await database;
    return await conexion!.delete(_nombreTBL,where: 'id = ? ', whereArgs: [id]);

  }

  Future<List<NotasModel>> getAllNotes() async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
   return result.map((notaMap) => NotasModel.fromMap(notaMap)).toList();
  }

  Future<NotasModel> getNote(int id) async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL, where: 'id= ?', whereArgs: [id]);
    return NotasModel.fromMap(result.first);
  }
}