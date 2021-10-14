import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:practica2/src/database/database_helper_tareas.dart';
import 'package:practica2/src/models/tareas_model.dart';

class AgregarTareasScreen extends StatefulWidget {
  TareasModel? tarea;
  AgregarTareasScreen({Key? key, this.tarea}) : super(key: key);

  @override
  _AgregarTareasScreenState createState() => _AgregarTareasScreenState();
}

class _AgregarTareasScreenState extends State<AgregarTareasScreen> {
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _contollerDescripcion = TextEditingController();
  TextEditingController _contollerDate = TextEditingController();

  late DateTime _fechaBD;
  String TextBar = '';

  bool mensajeT = false;
  bool mensajeD = false;
  bool mensajeF = false;

  late DatabaseHelperTarea _databaseHelperTarea;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.tarea != null) {
      _controllerTitulo.text = widget.tarea!.nomTarea!;
      _contollerDescripcion.text = widget.tarea!.dscTarea!;
      _contollerDate.text = widget.tarea!.fechaEntrega!;
      TextBar = 'Editar Tarea';
    } else {
      TextBar = 'Agregar Tarea';
    }
    _databaseHelperTarea = DatabaseHelperTarea();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 15),
              child: ElevatedButton.icon(
                  icon: Icon(Icons.check),
                  label: Text('Añadir'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_controllerTitulo.text.isEmpty) {
                        mensajeT = true;
                      } else {
                        mensajeT = false;

                        if (_contollerDescripcion.text.isEmpty) {
                          mensajeD = true;
                        } else {
                          mensajeD = false;

                          if (_contollerDate.text.isEmpty) {
                            mensajeF = true;
                          } else {
                            mensajeF = false;
                            if (widget.tarea == null) {
                              TareasModel tarea = TareasModel(
                                  nomTarea: _controllerTitulo.text,
                                  dscTarea: _contollerDescripcion.text,
                                  fechaEntrega: _fecha,
                                  entregada: 1);

                              _databaseHelperTarea.insert(tarea.toMap()).then((value) {
                                if (value > 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Se agrego una tarea')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Error, la solicitud no se completo.')));
                                }
                              });
                            } else {
                              TareasModel tarea = TareasModel(
                                  idTarea: widget.tarea!.idTarea,
                                  nomTarea: _controllerTitulo.text,
                                  dscTarea: _contollerDescripcion.text,
                                  fechaEntrega: _contollerDate.text,
                                  entregada: 1);
                              _databaseHelperTarea.update(tarea.toMap()).then((value) {
                                if (value > 0) {
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Error, la solicitud no se completo.')));
                                }
                              });
                            }
                          }
                        }
                      }
                    });
                  }),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TextPrincipal(),
            _Titulo(),
            _Descripcion(),
            _Fecha(context),
          ],
        ));
  }

  Widget _TextPrincipal() {
    return Container(
        margin: EdgeInsets.only(top: 15, left: 15, bottom: 15),
        child: Text(TextBar,
            style:
                GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold)));
  }

  Widget _Titulo() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Título",
                style: GoogleFonts.lato(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
                controller: _controllerTitulo,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Agrega el título',
                    errorText: mensajeT ? 'Este campo es obligatorio' : null)),
          ],
        ),
      ),
    );
  }

  Widget _Descripcion() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Descripción",
                style: GoogleFonts.lato(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
                controller: _contollerDescripcion,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Agrega una descripción',
                    errorText: mensajeD ? 'Este campo es obligatorio' : null)),
          ],
        ),
      ),
    );
  }

  Widget _Fecha(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fecha entrega",
                style: GoogleFonts.lato(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              enableInteractiveSelection: false,
              controller: _contollerDate,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  suffixIcon: Icon(Icons.calendar_today),
                  hintText: 'dd-mm-yyyy',
                  errorText: mensajeF ? 'Este campo es obligatorio' : null),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _fecha = '';

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _fechaBD = picked;
        _fecha = DateFormat('yyyy-MM-dd').format(picked);
        _contollerDate.text = _fecha;
      });
    }
  }
}
