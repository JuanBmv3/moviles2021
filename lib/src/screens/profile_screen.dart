import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/database_helper_profile.dart';
import 'package:practica2/src/models/profile_model.dart';

class ProfileScreen extends StatefulWidget {

 
 ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  

  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _aPaternoController = new TextEditingController();
  TextEditingController _aMaternoController = new TextEditingController();
  TextEditingController _numTelController = new TextEditingController();
  TextEditingController _correoController = new TextEditingController();

 
  File? _image;

  late DatabaseHelperProfile _databaseHelperProfile;

  String imageNow = "";
  String imageBefore = "";
  String imgDB = "";
  var profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelperProfile =  DatabaseHelperProfile();


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
              profile = snapshot.data;
        _nombreController.text = profile!.nombre!;
        _aPaternoController.text = profile.a_paterno!;
        _aMaternoController.text = profile.a_materno!;
        _numTelController.text = profile.num_tel!;
        _correoController.text = profile.correo!;
        imageBefore = profile.image;
        
        
        return Scaffold(
          appBar: AppBar(
            title: Text('Perfil')
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: [
              _imageProfile(),
              Divider(),
              _inputNombre(),
              Divider(),
              _inputApaterno(),
              Divider(),
              _inputAmaterno(),
              Divider(),
              _inputNumTel(),
              Divider(),
              _crearEmail(),
              Divider(),
              _buttonConfirm(),
            ],
          )
        );
            }else{
              return Center(child:CircularProgressIndicator(),);
            }
          }
        },

      );
        
     
  }

  Widget _imageProfile(){
    return Center(
        child: 
          GestureDetector(
            onTap:() => _alertImage(context),
            child: _imageNow(),
          )   
      );
    
  }

  Widget _inputNombre() {
    return TextField(
      controller:_nombreController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle)
      ),

      
    );
  }

   Widget _inputApaterno(){
    return TextField(
      controller: _aPaternoController ,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Apellido Paterno',
        labelText: 'Apellido Paterno',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle)
      ),

     


    );
  }

   Widget _inputAmaterno() {
    return TextField(
      controller: _aMaternoController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Apellido Materno',
        labelText: 'Apellido Materno',
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle)
      ),

     


    );
  }

 Widget _inputNumTel() {
    return TextField(
      controller: _numTelController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Num. Telefonico',
        labelText: 'Num. Telefonico',
        suffixIcon: Icon(Icons.dialpad),
        icon: Icon(Icons.contact_phone),
      ),
    );
  }

  Widget _crearEmail() {
    return TextField(
      controller: _correoController,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Correo Electronico',
        labelText: 'Correo Electronico',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email)
      ),

     
    );
  }

  Widget _buttonConfirm() {
   return ElevatedButton(
      style: ElevatedButton.styleFrom(
      primary: Colors.blue
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.check),
        Text('Confirmar')
      ],
    ),
    onPressed: (){
      
      if(_image == null){
        imgDB = imageBefore;
      }else{
        imgDB = imageNow;
      }
        ProfileModel profile = ProfileModel(
          id: 1,
          nombre: _nombreController.text,
          a_paterno: _aPaternoController.text,
          a_materno: _aMaternoController.text,
          num_tel: _numTelController.text,
          correo: _correoController.text,
          image: imgDB
        );

        _databaseHelperProfile.update(profile.toMap()).then((value) {
          if(value > 0){
             ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text('Se agrego tu informacion de perfil')
               )
              );
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error, la solicitud no se completo.')
              )
            );
          }
        } );
    },
  );      
 }

  

  Future pickImage(ImageSource source) async{
    final _image = await ImagePicker().pickImage(source: source);
    if(_image == null) return;
    
    final imageTemporary = File(_image.path);
    setState(() {
       this._image = imageTemporary;

      imageNow = _image.path;


      print("tu path es ${imageNow}");
    });
    
    
    
  }

  void _alertImage(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(

          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
          title: Text('Selecciona tu imagen'),
          content: Row(
             mainAxisSize: MainAxisSize.min,
            children : [
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                icon: Icon(Icons.camera),
                label: Text('Camara', ),
                onPressed: ()  {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                }
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton.icon(
                  
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  icon: Icon(Icons.insert_photo),
                  label: Text('Galeria', ),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                    print(_image?.path);
                  }
                ),
              ),
             
            ],
          ),
          actions : [
          
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              }
            )
          ]
        );
      },
    );
  }

  Widget _imageNow() {   
    if(profile.image == '' && _image == null){
      return CircleAvatar(
        backgroundImage: NetworkImage('https://www.tekcrispy.com/wp-content/uploads/2018/10/avatar.png'),
        radius:  80,
        backgroundColor: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white
            ),
          )
        )
      );
    }

    return CircleAvatar(
      backgroundImage:  _image != null ? 
        Image.file(_image!,fit:BoxFit.cover).image : Image.file(File(profile.image),fit:BoxFit.cover).image ,
      radius:  80,
      backgroundColor: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.camera_alt,
            color: Colors.white
          ),
        )
      )
    );
  }
}