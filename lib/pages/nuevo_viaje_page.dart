
import 'package:appcamiones/pages/inicio_page.dart';
import 'package:appcamiones/pages/usuario_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//se puede inicializar los valores tomando en cuenta desde el inicio los valores por defecto de full asi luego al llamarlo se modifican
const List<String> list = <String>['IDA', 'REDONDO'];

const List<String> lista = <String>['Full', 'Sencillo Caja Seca','Sencillo Caja Refrigerada'];

double administracion=1;
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

double transferVF=0;
double dieselVF=0;
double dieselThermoVF=0;
double administracionVF=0;
double cargaLaboraVF=0;
double depreciacionVF=0;
double direccionOGOIVF=0;
double diversosTranspVF=0;
double infraestructuraVF=0;
double llantasVF=0;
double mantenimientoVF=0;
double pagoOperadorVF=0;
double rastreoSatelitalVF=0;
double seguroCajaVF=0;
double seguroTractoVF=0;
double tarifaVF=0;
double tarifaDolaresVF=0;
double costoVF=0;
double costoDolaresVF=0;
String _tipoViaje= "IDA";
String _tipoUnidad= "Full";


class ModalNuevoViaje extends StatefulWidget{
  const ModalNuevoViaje({super.key});
  //const ModalNuevoViaje(Key? key) : super(key: key);
  @override
  State<ModalNuevoViaje> createState() => _ModalNuevoViajeState();

}

class _ModalNuevoViajeState extends State<ModalNuevoViaje>{
  void route() async {
    var collection = FirebaseFirestore.instance.collection('Factores');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
       if("Full" == data['Tipo de Unidad']){
        _tipoUnidad=data['Tipo de Unidad'].toString();
        _tipoViaje= "IDA";
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
  //Gernerales de Tarifa
  final TextEditingController _FechaTarifa= TextEditingController();
  final TextEditingController _Origen= TextEditingController();
  final TextEditingController _Destino= TextEditingController();
  final TextEditingController _Recolecciones= TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  //Datos Operativos
  final TextEditingController _Transfer= TextEditingController(text: '0');
  final TextEditingController _Kilometros= TextEditingController();
  final TextEditingController _Dias_Viaje= TextEditingController();
  final TextEditingController _Casetas= TextEditingController();
  final TextEditingController _Precio_Diesel= TextEditingController();
  final TextEditingController _Rendimiento_Tracto= TextEditingController();
  final TextEditingController _Litros_Diesel_Thermo= TextEditingController();

  //Resultado
  final TextEditingController _Utilidad= TextEditingController(text: '1');
  final TextEditingController _Precio_Dolar= TextEditingController();



  
  final GlobalKey<FormState> _formularioKey = GlobalKey<FormState>();

  /*void route(String factor) async {
    var collection = FirebaseFirestore.instance.collection('Factores');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
       factor = data['Tipo de Unidad'];
       print(factor);
    }
  }*/
  @override
  Widget build(BuildContext context){
      route();
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
                Container(
                  alignment: Alignment.center,
                  child: const Text("Generales de la tarifa",
                    style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _FechaTarifa,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9./]'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Fecha de Tarifa"
                    
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Origen,
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
                  controller: _Recolecciones,
                  decoration: const InputDecoration(
                    labelText: "Recolecciones"
                  ),
                ),
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
                Container(
                  alignment: Alignment.center,
                  child: const Text("Datos operativos",
                    style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _Transfer,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Transfer"
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
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text("Factores",
                    style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getPagoOperador(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      pagoOperadorVF=0;
                    }else{
                     pagoOperadorVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Pago Operador: \$ $pagoOperadorVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getDiesel(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      dieselVF=0;
                    }else{
                     dieselVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Diesel: \$ $dieselVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getDieselThermo(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      dieselThermoVF=0;
                    }else{
                     dieselThermoVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Diesel / Thermo: \$ $dieselThermoVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getCargaLaboral(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      cargaLaboraVF=0;
                    }else{
                     cargaLaboraVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Carga Laboral: \$ $cargaLaboraVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getMantenimiento(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      mantenimientoVF=0;
                    }else{
                     mantenimientoVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Mantenimiento: \$ $mantenimientoVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getLlantas(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      llantasVF=0;
                    }else{
                     llantasVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Llantas: \$ $llantasVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getSeguroTracto(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      seguroTractoVF=0;
                    }else{
                     seguroTractoVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Seguro Tracto: \$ $seguroTractoVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getSeguroCaja(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      seguroCajaVF=0;
                    }else{
                     seguroCajaVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Seguro Caja: \$ $seguroCajaVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getDepreciacion(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      depreciacionVF=0;
                    }else{
                     depreciacionVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Depreciación: \$ $depreciacionVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getRastreoSatelital(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      rastreoSatelitalVF=0;
                    }else{
                     rastreoSatelitalVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Rastreo Satelital: \$ $rastreoSatelitalVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getDiversosTransp(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      diversosTranspVF=0;
                    }else{
                     diversosTranspVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Diversos Transp.: \$ $diversosTranspVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getAdministracion(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      administracionVF=0;
                    }else{
                     administracionVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Administración: \$ $administracionVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getIntraestructura(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      infraestructuraVF=0;
                    }else{
                     infraestructuraVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Infraestructura: \$ $infraestructuraVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getDireccionOGOI(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      direccionOGOIVF=0;
                    }else{
                     direccionOGOIVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Direccion OGOI: \$ $direccionOGOIVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text("Resultado",
                    style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _Utilidad,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Utilidad"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _Precio_Dolar,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                    labelText: "Precio Dolar"
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Este campo es requerido';
                    }
                    return null;
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getCosto(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      costoVF=0;
                    }else{
                     costoVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Costo: \$ $costoVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getCostoDolares(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      costoDolaresVF=0;
                    }else{
                     costoDolaresVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Costo Dolares: \$ $costoDolaresVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getTarifa(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      tarifaVF=0;
                    }else{
                     tarifaVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Tarifa: \$ $tarifaVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<double?>(
                  initialData: 0,
                  stream: getTarifaDolares(),
                  builder: (context, snapshot) {
                    final temporal = snapshot.data?.toStringAsFixed(2);
                    if(temporal==null){
                      tarifaDolaresVF=0;
                    }else{
                     tarifaDolaresVF=double.parse(temporal.toString());
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(
                          'Tarifa Dolares: \$ $tarifaDolaresVF',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
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
                                    if(respuesta){
                                      
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(),
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
                       
                      child: const Text("Aceptar"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
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
                    ),
                  ],
                )
              ],)
          )),
      ),
    ),
    
    );
  }
  Stream<double> getAdministracion() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> administracion*double.parse(_Kilometros.text),);

  Stream<double> getDiesel() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> (double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text));

  Stream<double> getDieselThermo() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text));

  Stream<double> getCargaLaboral() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Dias_Viaje.text)*cargaLaboral);

  Stream<double> getMantenimiento() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Kilometros.text)*mantenimiento);

  Stream<double> getLlantas() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Kilometros.text)*llantas);

  Stream<double> getSeguroTracto() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Dias_Viaje.text)*seguroTracto);

  Stream<double> getSeguroCaja() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Dias_Viaje.text)*seguroCaja);

  Stream<double> getDepreciacion() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Dias_Viaje.text)*depreciacion);

  Stream<double> getRastreoSatelital() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Dias_Viaje.text)*rastreoSatelital);

  Stream<double> getDiversosTransp() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Kilometros.text)*diversosTransp);

  Stream<double> getIntraestructura() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Dias_Viaje.text)*infraestructura);

  Stream<double> getDireccionOGOI() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> double.parse(_Kilometros.text)*direccionOGOI);

  Stream<double> getPagoOperador() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> (double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador);
  Stream<double> getCosto() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> (double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))+((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador));

  Stream<double> getTarifa() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> (double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI)+((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador))*double.parse(_Utilidad.text));

  Stream<double> getTarifaDolares() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> ((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI)+((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador))*double.parse(_Utilidad.text))/double.parse(_Precio_Dolar.text));

  Stream<double> getCostoDolares() => Stream<double>.periodic(Duration(seconds: 1),
  (count)=> ((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))+((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador))/double.parse(_Precio_Dolar.text));
  
    nuevoViaje() async{
  try{
    await FirebaseFirestore.instance.collection('Viajes').add({'Fecha de Tarifa':_FechaTarifa.text,
    'Origen':_Origen.text,
    'Transfer':_Transfer.text,
    'Destino':_Destino.text,
    'Recolecciones':_Recolecciones.text,
    'Tipo de Viaje': _tipoViaje,
    'Tipo de Unidad':_tipoUnidad,
    'Utilidad':_Utilidad.text,
    'Tarifa Dolares':(((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI)+((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador))*double.parse(_Utilidad.text))/double.parse(_Precio_Dolar.text)).toStringAsFixed(2),
    'Costo Dolares':(((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))+((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador))/double.parse(_Precio_Dolar.text)).toStringAsFixed(2),
    'Tarifa':((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI)+((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador))*double.parse(_Utilidad.text)).toStringAsFixed(2),
    'Costo':((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))+((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador)).toStringAsFixed(2),
    'Kilómetros':_Kilometros.text,
    'Días Viaje':_Dias_Viaje.text,
    'Casetas':_Casetas.text,
    'Precio del Diesel':_Precio_Diesel.text,
    'Rendimiento Tracto':_Rendimiento_Tracto.text,
    'Litros Diesel Thermo':_Litros_Diesel_Thermo.text,
    'Pago Operador':((double.parse(_Transfer.text)+(double.parse(_Dias_Viaje.text)*infraestructura)+
  ( double.parse(_Kilometros.text)*diversosTransp)+(administracion*double.parse(_Kilometros.text))+
  (double.parse(_Dias_Viaje.text)*rastreoSatelital)+(double.parse(_Dias_Viaje.text)*depreciacion)+
  (double.parse(_Dias_Viaje.text)*seguroCaja)+(double.parse(_Dias_Viaje.text)*seguroTracto)+
  (double.parse(_Kilometros.text)*llantas)+(double.parse(_Kilometros.text)*mantenimiento)+
  (double.parse(_Dias_Viaje.text)*cargaLaboral)+(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text))+
  double.parse(_Casetas.text)+((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text))+
  (double.parse(_Kilometros.text)*direccionOGOI))*pagoOperador).toStringAsFixed(2),
    'Diesel':((double.parse(_Kilometros.text)/double.parse(_Rendimiento_Tracto.text))*double.parse(_Precio_Diesel.text)).toStringAsFixed(2),
    'Diesel  Thermo':(double.parse(_Litros_Diesel_Thermo.text)*double.parse(_Precio_Diesel.text)).toStringAsFixed(2),
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
    return false;
  }
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
                          route(value);
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



