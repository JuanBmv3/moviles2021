import 'package:flutter/material.dart';

class PropinaPage extends StatefulWidget {
  PropinaPage({Key? key}) : super(key: key);

  @override
  _PropinaPageState createState() => _PropinaPageState();
}

class _PropinaPageState extends State<PropinaPage> {
  var controller = TextEditingController();
  double monto = 0;
  double propina = 0;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de propinas'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
             child: cardMonto(),
            ),
            SizedBox(height: 30.0),
            buttonPay(),
          ],),
      ) ,
      
    );
    
  }

  Widget cardMonto() {
      return Card(
        margin: EdgeInsets.only(left: 15, right: 15),
        elevation: 10.0, 
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              ListTile(
                title: Text('Ingrese el monto total del consumo'),
                leading: Icon(Icons.attach_money , color: Colors.green),
              ),

                  TextField(  
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      labelText: 'Monto',
                      suffixIcon: Icon(Icons.local_atm),
                     
                    ),
                    onChanged: (valor){
                      setState(() {
                        monto = double.parse(valor);
                        propina = monto * .15;
                        total = propina + monto;
                        print(propina);
                      });
                    }
                  )
                
            ],),
        )
      );
  }

 Widget buttonPay() {
   return FloatingActionButton(
      child: Icon(Icons.check),
      onPressed: (){
      alerta(context);
    }
  );      
 }

  void alerta(BuildContext context) {
    showDialog(
      
      context: context,
      
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
          title: Text('Contenido de Pago total'),
          content: Column(
             mainAxisSize: MainAxisSize.min,
            children : [
              
              Text('Monto total de consumo: \$$monto ', textAlign: TextAlign.center),
              Divider(),
              Text('Propina: \$$propina ', textAlign: TextAlign.center),
              Divider(),
              Text('Pago Total: \$$total ', textAlign: TextAlign.center)
            ],
          ),
          actions : [
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop()
            ),
            ElevatedButton(
              child: Text('Confirmar'),
              onPressed: () {
                controller.clear();
                Navigator.of(context).pop();
              }
            )
          ]
        );
      },
    );
  }

}