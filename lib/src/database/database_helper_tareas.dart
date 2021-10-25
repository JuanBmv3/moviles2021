import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperTarea{
  static final _nombreBD = "TAREASBD";
  static final _versionBD = 1;
  static final _nombreTBL = "tblTareas";

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
    await db.execute("CREATE TABLE $_nombreTBL (idTarea INTEGER PRIMARY KEY, nomTarea VARCHAR(50), dscTarea VARCHAR(100), fechaEntrega date, entregada int(1)) ");
  }

  Future<int> insert(Map<String, dynamic> row) async{
    var conexion = await database;
   
    return conexion!.insert(_nombreTBL,row);
  }

  Future<int> update(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.update(_nombreTBL,row, where: 'idTarea = ?', whereArgs:[row['idTarea']] );

  }

  Future<int> updateEntregado(Map<String, dynamic> row) async{
    var conexion = await database;

    return conexion!.update(_nombreTBL,row, where: 'idTarea = ?', whereArgs:[row['idTarea']] );

  }

  Future<int> delete(int id ) async{
    var conexion = await database;
    return await conexion!.delete(_nombreTBL,where: 'idTarea = ? ', whereArgs: [id]);

  }

  Future<List<TareasModel>> getTareasActuales() async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL, where: 'entregada = ',);
   return result.map((notaMap) => TareasModel.fromMap(notaMap)).toList();
  }
  
  Future<List<TareasModel>> getTareasFinalizadas() async{
    var conexion = await database;
    var result = await conexion!.rawQuery('SELECT *  from ${_nombreTBL} WHERE NOT entregada = 1 ');
   return result.map((notaMap) => TareasModel.fromMap(notaMap)).toList();
  }

}