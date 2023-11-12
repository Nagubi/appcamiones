import 'package:appcamiones/pages/calculo_page_normal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//se puede inicializar los valores tomando en cuenta desde el inicio los valores por defecto de full asi luego al llamarlo se modifican
const List<String> list = <String>['IDA', 'REDONDO'];

const List<String> lista = <String>[ 'Caja Seca','Caja Refrigerada'];
const List<String> lista2 = <String>['Propia', 'Americana'];
const List<String> lista3 = <String>['Full', 'Sencillo'];
double costoDolaresVF=0;
String _tipoViaje= "IDA";
String _tipoUnidad= "Caja Seca";
String _tipoCaja= "Propia";
String _tipoOperacion= "Full";


class ModalNuevoViaje1 extends StatefulWidget{
  const ModalNuevoViaje1({super.key});
  @override
  State<ModalNuevoViaje1> createState() => _ModalNuevoViaje1State();

}

class _ModalNuevoViaje1State extends State<ModalNuevoViaje1>{
  //Gernerales de Tarifa
  final user = FirebaseAuth.instance.currentUser!;
  //Datos Operativos

  //Resultado

  final GlobalKey<FormState> _formularioKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
     _tipoViaje= "IDA";
    _tipoUnidad= "Caja Seca";
    _tipoCaja= "Propia";
    _tipoOperacion= "Full";
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
    child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 63, 59, 59)),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
        color: Colors.white,
        child: Form(
          key: _formularioKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Text(
                      "Tipo de Operacion",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                 DropdownButtonExample4(),
                 const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Text(
                      "Tipo de Unidad",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                DropdownButtonExample2(),
                 const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Text(
                      "Tipo de Caja",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                DropdownButtonExample3(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: Text(
                      "Tipo de Viaje",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                 DropdownButtonExample(),
                 const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: ()  {
                        if (_formularioKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CalculoNormal(tipoViaje: _tipoViaje,tipoCaja: _tipoCaja,tipoOperacion: _tipoOperacion,tipoUnidad: _tipoUnidad,),
                              ),
                            );
                          
                        }else{
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text('Faltan Campos por llenar'),
                              actions: [
                                TextButton(
                                  child: Text("Aceptar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                
                            
                          ],
                          ),
                        );
                        }
                      },
                       style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(15),
                    ),
                      child: const Text("Continuar"),
                    ),
                    const SizedBox(height: 10),
                    /*ElevatedButton(
                      onPressed: () =>
                         showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Cancelar"),
                          content: Text('Seguro que desea cancelar?'),
                          actions: [
                            TextButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: new Text("Si"),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                 );
                              },
                            ),
                            
                          ],
                          ),
                        ),
                      child: const Text("Cancelar"),
                    ),*/
                  ],
                )
              ],)
          )),
      ),
    ),
    
    );
  }
  

  
}


  

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
       hint: Container(
        width: MediaQuery.of(context).size.width /1.5,
      ),
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
           _tipoViaje=value;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 18)),
        );
      }).toList(),
    );
  }
}
class DropdownButtonExample3 extends StatefulWidget {
  const DropdownButtonExample3({super.key});

  @override
  State<DropdownButtonExample3> createState() => _DropdownButtonExampleState3();
}

class _DropdownButtonExampleState3 extends State<DropdownButtonExample3> {
  String dropdownValue = lista2.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
       hint: Container(
        width: MediaQuery.of(context).size.width /1.5,
      ),
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
           _tipoCaja=value;
        });
      },
      items: lista2.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 18)),
        );
      }).toList(),
    );
  }
}
class DropdownButtonExample2 extends StatefulWidget {
  const DropdownButtonExample2({super.key});

  @override
  State<DropdownButtonExample2> createState() => _DropdownButtonExampleState2();
}

class _DropdownButtonExampleState2 extends State<DropdownButtonExample2> {
  String dropdownValue = lista.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
       hint: Container(
        width: MediaQuery.of(context).size.width /1.5,
      ),
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          
          dropdownValue = value!;
          _tipoUnidad=value;
        });
      },
      items: lista.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 20)),
        );
      }).toList(),
    );
  }
  
  

}

class DropdownButtonExample4 extends StatefulWidget {
  const DropdownButtonExample4({super.key});

  @override
  State<DropdownButtonExample4> createState() => _DropdownButtonExampleState4();
}

class _DropdownButtonExampleState4 extends State<DropdownButtonExample4> {
  String dropdownValue = lista3.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
       hint: Container(
        width: MediaQuery.of(context).size.width /1.5,
      ),
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
           _tipoOperacion=value;
        });
      },
      items: lista3.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: 18)),
        );
      }).toList(),
    );
  }
}



