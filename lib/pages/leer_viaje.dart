import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeerViajeScreen extends StatefulWidget{
  LeerViajeScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<LeerViajeScreen> createState() => _LeerViajeScreenState();

}

class _LeerViajeScreenState extends State<LeerViajeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(218, 229, 226, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Generales de la Tarifa",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
              "Fecha de Tarifa:"+widget.doc["Fecha de Tarifa"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Origen:"+widget.doc["Origen"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Destino:"+widget.doc["Destino"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Tipo de Operacion:"+widget.doc["Tipo de Operacion"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Tipo de Viaje:"+widget.doc["Tipo de Viaje"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Tipo de Unidad:"+widget.doc["Tipo de Unidad"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              const Text("Resultado",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
              "Utilidad:"+widget.doc["Utilidad"]+"%",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Tarifa Dolares:"+widget.doc["Tarifa Dolares"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Costo Dolares:"+widget.doc["Costo Dolares"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Tarifa:"+widget.doc["Tarifa"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Costo:"+widget.doc["Costo"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              const Text("Factores",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
              "Costo Recolecciones:"+widget.doc["Costo Recolecciones"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Transfer:"+widget.doc["Transfer"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Kilómetros:"+widget.doc["Kilómetros"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Días Viaje:"+widget.doc["Días Viaje"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Casetas:"+widget.doc["Casetas"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Precio del Diesel:"+widget.doc["Precio del Diesel"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Rendimiento Tracto:"+widget.doc["Rendimiento Tracto"],
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Litros Diesel Thermo:"+widget.doc["Litros Diesel Thermo"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              const Text("Datos Operativos",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
              "Pago Operador:"+widget.doc["Pago Operador"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Diesel:"+widget.doc["Diesel"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Diesel Thermo:"+widget.doc["Diesel  Thermo"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Carga Laboral:"+widget.doc["Carga Laboral"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Mantenimiento:"+widget.doc["Mantenimiento"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Llantas:"+widget.doc["Llantas"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Seguro Tracto:"+widget.doc["Seguro Tracto"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Seguro Caja:"+widget.doc["Seguro Caja"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Depreciación:"+widget.doc["Depreciación"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Rastreo Satelital:"+widget.doc["Rasteo Satelital"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Diversos Transp.:"+widget.doc["Diversos Transp"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Administración:"+widget.doc["Administración"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Infraestructura:"+widget.doc["Infraestructura"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              Text(
              "Direccion OGOI:"+widget.doc["Direccion OGOI"].toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
            ],
          ),
        ),),
    );
  }

}