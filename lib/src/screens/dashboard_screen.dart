import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper_profile.dart';
import 'package:practica2/src/models/profile_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DatabaseHelperProfile _databaseHelperProfile;

  @override
  void initState(){
    super.initState();
    _databaseHelperProfile = new DatabaseHelperProfile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _databaseHelperProfile.getProfile(),
      builder: (_,AsyncSnapshot<ProfileModel?> snapshot){
         if(snapshot.hasError){
            return Center(child: Text("Ocurrio un error en la peticion"),);
          }else{
            if(snapshot.connectionState == ConnectionState.done){
            final profile = snapshot.data;
        
        return  Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: ColorSettings.colorPrimary,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              GestureDetector(
                onTap:() => Navigator.pushNamed(context, '/profile'),
                child: UserAccountsDrawerHeader(
                
                  accountName: Text("${profile!.nombre!} ${profile.a_paterno!} ${profile.a_materno!} ") , 
                  accountEmail: Text("${profile.correo!} -- ${profile.num_tel!} "),
                  
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: profile.image != '' ? 
                   Image.file(File(profile.image!) ,fit:BoxFit.cover).image : NetworkImage('https://www.tekcrispy.com/wp-content/uploads/2018/10/avatar.png') ,
                    backgroundColor: Colors.transparent,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.black,
                        child: Icon(
                          
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      )
                    )
                  ),
                 
                ),
              ),
              ListTile(
                title: Text('Propinas'),
                subtitle: Text('Pract 1. Calculadora de Propinas'),
                leading: Icon(Icons.monetization_on_outlined),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/opc1');
                  
                },
              ),
              ListTile(
                title: Text('Intenciones'),
                subtitle: Text('Intenciones implicitas'),
                leading: Icon(Icons.sms),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/intenciones');
                },
              ),
              ListTile(
                title: Text('Notas'),
                subtitle: Text('CRUD Notas'),
                leading: Icon(Icons.note),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/notas');
                },
              ),
               ListTile(
                title: Text('Movies'),
                subtitle: Text('Prueba API REST'),
                leading: Icon(Icons.movie),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/movie');
                },
              ),
            ],
          )
        ),
      );
            }else{
              return Center(child:CircularProgressIndicator(),);
            }
          }
        },

      );

        
      }
     
}