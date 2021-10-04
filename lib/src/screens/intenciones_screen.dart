import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intenciones Implicitas"),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            child: ListTile(
              title: Text('Abrir Pagina'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 19.0, color: Colors.blue),
                  Text('https://celaya.tecnm.mx/'),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 10.0),
                height: 40.0,
                child: Icon(Icons.language, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right:BorderSide(width:1.0))
                )
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _abrirWeb,
            )
          ),
           Card(
            elevation: 8.0,
            child: ListTile(
              title: Text('Llamada telefonica'),
              subtitle: Row(
                children: [
                  Icon(Icons.phone, size: 19.0, color: Colors.blue),
                  Text('Cel: 4612738301'),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 10.0),
                height: 40.0,
                child: Icon(Icons.phone_android, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right:BorderSide(width:1.0))
                )
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: llamadaTelefonica,
            )
          ),
           Card(
            elevation: 8.0,
            child: ListTile(
              title: Text('Enviar SMS'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 19.0, color: Colors.blue),
                  Text('Cel: 4612738301'),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 10.0),
                height: 40.0,
                child: Icon(Icons.sms, color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right:BorderSide(width:1.0))
                )
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: enviarSMS,
            )
          ),
           Card(
            elevation: 8.0,
            child: ListTile(
              title: Text('Enviar Email'),
              subtitle: Row(
                children: [
                  Icon(Icons.person, size: 19.0, color: Colors.blue),
                  Text('To: juan.cbm1998@gmail.com'),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 10.0),
                height: 40.0,
                child: Icon(Icons.email,color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right:BorderSide(width:1.0))
                )
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: enviarEmail,
            )
          ),
           Card(
            elevation: 8.0,
            child: ListTile(
              title: Text('Tomar Foto'),
              subtitle: Row(
                children: [
                  Icon(Icons.person, size: 19.0, color: Colors.blue),
                  Text('Sonrie :D'),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 10.0),
                height: 40.0,
                child: Icon(Icons.camera,color: Colors.black),
                decoration: BoxDecoration(
                  border: Border(right:BorderSide(width:1.0))
                )
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                print("1");
              }
            )
          ),
        ]
      )
    );
    
  }

_abrirWeb() async{
  const url = 'https://google.com/';
  if(await canLaunch(url)){
    await launch(url);
  }
}

llamadaTelefonica() async{
  const url = "tel:4612738301";
  if(await canLaunch(url)){
    await launch(url);
  }
}

enviarSMS() async{
 const url = "sms:4612738301";
  if(await canLaunch(url)){
    await launch(url);
  }
}

enviarEmail() async{
  final Uri params = Uri(
    scheme: "mailto",
    path: 'juan@hotmail.com',
    query: 'subject=Saludos&body=Bienvenido :D',
  );

  var email = params.toString();
  if(await canLaunch(email)){
    await launch(email);
  }

}

tomarFoto(){

}



}