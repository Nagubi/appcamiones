import 'package:appcamiones/pages/inicio_page.dart';
import 'package:appcamiones/pages/resultado_calculo_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum tipomoneda { no, si }
enum SingingCharacter { no, si }

class CalculoNormal extends StatefulWidget {
  final String tipoViaje;
  final String tipoOperacion;
  final String tipoUnidad;
  final String tipoCaja;
  
   CalculoNormal({
    super.key,
    required this.tipoViaje,
    required this.tipoOperacion,
    required this.tipoUnidad,
    required this.tipoCaja,
  });

  @override
  State<CalculoNormal> createState() => _CalculoNormalState();
}

class _CalculoNormalState extends State<CalculoNormal> {
  String Fecha="1";
  double administracion=1;
void obtenerFecha(){
var now = DateTime.now();
final formatter =new DateFormat('dd-MM-yyyy');
 Fecha = formatter.format(now);
}

double cargaLaboral=1;

double depreciacion=1;

double direccionOGOI=1;

double diversosTransp=1;

double infraestructura=1;

double llantas=1;

double mantenimiento=1;

double pagoOperador=1;

double rastreoSatelital=1;

double seguroCaja=1;

double seguroTracto=1;

bool Transfer = true;
String _Transfer="0";
double tarifaDolaresVF=0;
double tarifaVF=0;
double costoVF=0;
double costoDolaresVF=0;
double costoRecolecciones=0;
double litrosDieselThermo=0;
SingingCharacter? _transferselect = SingingCharacter.no;
tipomoneda? moneda = tipomoneda.no;
final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _Origen= TextEditingController();

  final TextEditingController _Destino= TextEditingController();

  final GlobalKey<FormState> _formularioKey = GlobalKey<FormState>();
    final TextEditingController _Kilometros= TextEditingController();
  final TextEditingController _Dias_Viaje= TextEditingController();
  final TextEditingController _Casetas= TextEditingController();
  final TextEditingController _Precio_Diesel= TextEditingController();
  final TextEditingController _Rendimiento_Tracto= TextEditingController();
   final TextEditingController _Recolecciones= TextEditingController();
   final TextEditingController _Utilidad= TextEditingController();
    final TextEditingController precio_Dolar= TextEditingController();
    
      final TextEditingController _Litros_Diesel_Thermo= TextEditingController();
  @override
  
  Widget build(BuildContext context) {
    route(widget.tipoUnidad);
    obtenerFecha();
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
                TextFormField(
                  controller: _Origen,
                  inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[a-zA-Z ]"),
                          )
                        ],
                  decoration: const InputDecoration(
                    labelText: "Origen"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Destino,
                  inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[a-zA-Z ]"),
                          )
                        ],
                  decoration: const InputDecoration(
                    labelText: "Destino"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Kilometros,
                  decoration: const InputDecoration(
                    labelText: "Kilómetros"
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                
                TextFormField(
                  controller: _Casetas,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Casetas"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Dias_Viaje,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Días Viaje"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Precio_Diesel,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Precio del Diesel"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                Thermo(context),
                TextFormField(
                  controller: _Rendimiento_Tracto,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Rendimiento Tracto"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Recolecciones,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Costo Recolecciones"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: const Text('Sin Transfer'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.no,
                          groupValue: _transferselect,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _transferselect = value;
                              Transfer=false;
                              
                                _Transfer="0";
                              print(_Transfer);
                              
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Con Transfer'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.si,
                          groupValue: _transferselect,
                          onChanged: (SingingCharacter? value) {
                            setState(()  {
                              _transferselect = value;
                              Transfer=true;
                              
                              pedirTransfer();
                              
                              //final snapshot= await FirebaseFirestore.instance.collection('Transfer').doc('Transfer').get();
                              //FirebaseFirestore.instance.collection('Transfer').doc(user.uid).get().then((value) {_Transfer =  value.get('Transfer');});
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  
                TextFormField(
                  controller: _Utilidad,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Porcentaje de Utilidad(%)"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text("Tipo de Moneda",
                        style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      ListTile(
                        title: const Text('Pesos'),
                        leading: Radio<tipomoneda>(
                          value: tipomoneda.no,
                          groupValue: moneda,
                          onChanged: (tipomoneda? value) {
                            setState(() {
                              moneda = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Dolares'),
                        leading: Radio<tipomoneda>(
                          value: tipomoneda.si,
                          groupValue: moneda,
                          onChanged: (tipomoneda? value) {
                            setState(() {
                              moneda = value;
                            });
                          },
                        ),
                      ),
                       valorDolar(context,moneda.toString()),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: ()  {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("¿Seguro que quieres volver?"),
                              content: Text('Los datos se perderan'),
                              actions: [
                                TextButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: new Text("Si"),
                                  onPressed: ()  {
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
                        );
                      },
                       style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(15),
                    ),
                      child: const Text("Volver"),
                    ),
                    SizedBox(width: 5,),
                    ElevatedButton(
                      onPressed: ()  {
                        if (_formularioKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Nuevo Viaje"),
                              content: Text('Seguro que los valores son correctos'),
                              actions: [
                                TextButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: new Text("Si"),
                                  onPressed: () async {
                                    bool respuesta = await nuevoViaje();
                                    print(respuesta);
                                    if(respuesta){
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CalculoResultado(tipoViaje: widget.tipoViaje,tipoOperacion: widget.tipoOperacion,tipoUnidad: "${widget.tipoUnidad} ${widget.tipoCaja}",tarifa: tarifaVF,origen: _Origen.text,
                                          destino: _Destino.text,fecha:Fecha ,tarifaDolares: tarifaDolaresVF,
                                          precioDiesel: double.parse(_Precio_Diesel.text),utilidad: (1+(double.parse(_Utilidad.text)/100)),kilometros: double.parse(_Kilometros.text),costo: costoVF,costoDolares: costoDolaresVF,),
                                        ),
                                      );
                                      
                                    }
                                  },
                                  
                                ),
                            
                          ],
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
                  ]),
                ]
      ),
    ),
        ))));
    
  }
  void pedirTransfer() async {
    var collection = FirebaseFirestore.instance.collection('Transfer');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
        _Transfer=data['Transfer'].toString();
        print(_Transfer);
       }
    }
  
   nuevoViaje() async{
    if(_Recolecciones.text!=""){
      costoRecolecciones=double.parse(_Recolecciones.text);
    }else{
      costoRecolecciones=0;
    }
    if(_Litros_Diesel_Thermo.text!=""){
      litrosDieselThermo=double.parse(_Litros_Diesel_Thermo.text);
    }else{
      litrosDieselThermo=0;
    }
 tarifaVF=double.parse(((double.parse(_Transfer)+costoRecolecciones+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(litrosDieselThermo*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI)+((double.parse(_Transfer)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(litrosDieselThermo*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador))*(1+(double.parse(_Utilidad.text)/100))).toStringAsFixed(2));
  costoVF=double.parse(((double.parse(_Transfer)+costoRecolecciones+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(litrosDieselThermo*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))+((double.parse(_Transfer)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(litrosDieselThermo*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador)).toStringAsFixed(2));
    if(precio_Dolar.text!="0" && precio_Dolar.text!=""){
      print(precio_Dolar);
      costoDolaresVF=double.parse((tarifaVF/double.parse(precio_Dolar.text)).toStringAsFixed(2));
      tarifaDolaresVF=double.parse((costoVF/double.parse(precio_Dolar.text)).toStringAsFixed(2));
      print(tarifaDolaresVF);
    }else{
      tarifaDolaresVF=0;
      costoDolaresVF=0;
    }

  try{
    await FirebaseFirestore.instance.collection('Viajes').add({'Fecha de Tarifa':Fecha,
    'Origen':_Origen.text,
    'Transfer':_Transfer,
    'Destino':_Destino.text,
    'Costo Recolecciones':costoRecolecciones,
    'Tipo de Viaje': widget.tipoViaje,
    'Tipo de Operacion': widget.tipoOperacion,
    'Tipo de Unidad':"${widget.tipoUnidad} ${widget.tipoCaja}",
    'Utilidad':_Utilidad.text,
    'Tarifa Dolares':tarifaDolaresVF,
    'Costo Dolares':costoDolaresVF,
    'Tarifa':tarifaVF,
    'Costo':costoVF,
    'Kilómetros':_Kilometros.text,
    'Días Viaje':_Dias_Viaje.text,
    'Casetas':_Casetas.text,
    'Precio del Diesel':_Precio_Diesel.text,
    'Rendimiento Tracto':_Rendimiento_Tracto.text,
    'Litros Diesel Thermo':litrosDieselThermo,
    'Pago Operador':((double.parse(_Transfer)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(litrosDieselThermo*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador).toStringAsFixed(2),
    'Diesel':((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text)).toStringAsFixed(2),
    'Diesel  Thermo':(litrosDieselThermo*double.parse(_Precio_Diesel.text)).toStringAsFixed(2),
    'Carga Laboral':(double.parse(_Dias_Viaje.text)*cargaLaboral).toStringAsFixed(2),
    'Mantenimiento':(double.parse(_Kilometros.text)*mantenimiento).toStringAsFixed(2),
    'Llantas':(double.parse(_Kilometros.text)*llantas).toStringAsFixed(2),
    'Seguro Tracto':(double.parse(_Dias_Viaje.text)*seguroTracto).toStringAsFixed(2),
    'Seguro Caja':( double.parse(_Dias_Viaje.text)*seguroCaja).toStringAsFixed(2),
    'Depreciación':(double.parse(_Dias_Viaje.text)*depreciacion).toStringAsFixed(2),
    'Rasteo Satelital':(double.parse(_Dias_Viaje.text)*rastreoSatelital).toStringAsFixed(2),
    'Diversos Transp':(double.parse(_Kilometros.text)*diversosTransp).toStringAsFixed(2),
    'Administración':(administracion*double.parse(_Kilometros.text)).toStringAsFixed(2),
    'Infraestructura':(double.parse(_Dias_Viaje.text)*infraestructura).toStringAsFixed(2),
    'Direccion OGOI':(double.parse(_Kilometros.text)*direccionOGOI).toStringAsFixed(2),
    'Usuario':user.email});

    return true;
  }catch(e){
    print(e);
    return false;
  }
}

  Widget valorDolar(BuildContext context,String moneda){
    if(moneda=="tipomoneda.si"){
       return TextFormField(
      controller: precio_Dolar,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                decoration: const InputDecoration(
                                  labelText: "Tipo de Cambio"
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Este campo es requerido';
                                  }
                                  return null;
                                },
                              );
    }else{
      return const SizedBox.shrink();
    }
  }
  Widget Thermo(BuildContext context){
    if(widget.tipoUnidad.toString()=="Caja Refrigerada"){
       return TextFormField(
      controller: _Litros_Diesel_Thermo,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                decoration: const InputDecoration(
                                  labelText: "Litros Diesel Thermo"
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Este campo es requerido';
                                  }
                                  return null;
                                },
                              );
    }else{
      return SizedBox.shrink();
    }
  }
  void route(String? factor) async {
    var collection = FirebaseFirestore.instance.collection('Factores');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
       if(factor == data['Tipo de Unidad']){
        administracion=double.parse(data['Administracion'].toString());
        cargaLaboral=double.parse(data['CargaLaboral'].toString());
        depreciacion=double.parse(data['Depreciacion'].toString());
        direccionOGOI=double.parse(data['DireccionOGOI'].toString());
        diversosTransp=double.parse(data['DiversosTransp'].toString());
        infraestructura=double.parse(data['Infraestructura'].toString());
        llantas=double.parse(data['Llantas'].toString());
        mantenimiento=double.parse(data['Mantenimiento'].toString());
        pagoOperador=double.parse(data['PagoOperador'].toString());
        rastreoSatelital=double.parse(data['RastreoSatelital'].toString());
        seguroCaja=double.parse(data['SeguroCaja'].toString());
        seguroTracto=double.parse(data['SeguroTracto'].toString());

       }
    }
  }
}