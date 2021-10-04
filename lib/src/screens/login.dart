import 'package:flutter/material.dart';
import 'package:practica2/src/screens/dashboard_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {

  var isLoading = false;

  
  @override
  Widget build(BuildContext context) {
    TextEditingController txtEmailC = TextEditingController();
  TextEditingController txtPasswordC = TextEditingController();

    TextFormField txtEmail = TextFormField(
      controller: txtEmailC,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: 'Introduce el Email',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        
      ),
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5)
    )
  );

  TextFormField txtPwd = TextFormField(
    controller: txtPasswordC,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    
    decoration: InputDecoration(
      hintStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      hintText: 'Introduce el Password',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        
      ),
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
      
    )
  );

  ElevatedButton button = new ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: ColorSettings.colorButton
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.login),
        Text('Validar')
      ],
    ),
    onPressed: (){
      print(txtEmailC.text);
      isLoading = true;
      setState((){
        Future.delayed(
          Duration(seconds:5),(){
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> DashboardScreen()));
          }
        );
      });
    },
  );

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo.jpg'), 
              fit: BoxFit.fill 
            )
          ),
        ),
        Card(
          margin: EdgeInsets.only(left: 15, right: 15),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                txtEmail,
                SizedBox(height:10),
                txtPwd,
                SizedBox(height:10),
                button
              ],
            ),
          ),
          
        ),
        Positioned(
          child: Image.asset('assets/logo.png', width:200, ),
          top:50,

        ),
        Positioned(
          child: isLoading == true ? CircularProgressIndicator(): Container(),
          top:150
        ),
      ],
    );
  }
}