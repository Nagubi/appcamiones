import 'package:appcamiones/pages/inicio_page.dart';
import 'package:appcamiones/pages/resultado_calculo_1.dart';
import 'package:flutter/material.dart';


class DetallePropuesta extends StatefulWidget{
   final String tipoViaje;
  final String tipoOperacion;
  final String tipoUnidad;
  final String origen;
  final String fecha;
  final String destino;
  final double tarifa;
  final double precioDiesel;
  final String tipoCambio;
  final double kilometros;
  final double costo;
  final double costoDolares;
  final double tarifaDolares;
  final double utilidad;
   DetallePropuesta({
    super.key,
    required this.tipoViaje,
    required this.tipoOperacion,
    required this.tipoUnidad,
    required this.origen,
    required this.fecha,
    required this.destino,
    required this.tarifa,
    required this.precioDiesel,
    required this.tipoCambio,
    required this.kilometros,
    required this.costo,
    required this.costoDolares,
    required this.tarifaDolares,
    required this.utilidad,
  });
  @override
  State<DetallePropuesta> createState() => _DetallePropuestaState();

}

class _DetallePropuestaState extends State<DetallePropuesta>{
  double tarifaFinal=0;
  double costoFinal=0;
  @override
  Widget build(BuildContext context){
    if(widget.tarifaDolares==0){
        tarifaFinal=widget.tarifa;
      }else{
        tarifaFinal=widget.tarifaDolares;
      };
    if(widget.costoDolares==0){
        costoFinal=widget.costo;
      }else{
        costoFinal=widget.costoDolares;
      };
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
    child: Scaffold(
      backgroundColor: Color.fromARGB(218, 229, 226, 226),
      appBar: AppBar(
        title: Text('Detalles del Calculo'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
              "Fecha:",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.fecha,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Origen:",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.origen,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Destino:",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.destino,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Tipo de Operacion:",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.tipoOperacion,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Tipo de Unidad:",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.tipoUnidad,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),

              Row(children: [
                Text(
              "Tipo de Viaje:",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.tipoViaje,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Precio del Diesel: \$",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.precioDiesel.toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Tipo de Cambio:",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.tipoCambio,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Kilometros:",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              widget.kilometros.toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Costo: \$",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              costoFinal.toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Tarifa al 10%: \$",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              (costoFinal*1.10).toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Tarifa al 15%: \$",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              (costoFinal*1.15).toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Tarifa al 20%: \$",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              (costoFinal*1.20).toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                Text(
              "Tarifa al 25%: \$",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              (costoFinal*1.25).toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalculoResultado(tipoViaje: widget.tipoViaje,tipoOperacion: widget.tipoOperacion,tipoUnidad: widget.tipoUnidad,tarifa: widget.tarifa,origen: widget.origen,
                        destino: widget.destino,fecha:widget.fecha ,tarifaDolares: widget.tarifaDolares,
                        precioDiesel: widget.precioDiesel,utilidad: widget.utilidad,kilometros: widget.kilometros,costo: widget.costo,costoDolares: widget.costoDolares,),
                      ),
                    );
                    
                },
                style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(15),
                    ),
                child: const Text("Regresar"),
              ),
              SizedBox(width: 5,),
              ElevatedButton(
                      onPressed: ()  {
                         showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Finalizar Consulta"),
                      content: Text('Seguro que desea finalizar la consulta?'),
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
                      ));
                      },
                       style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(15),
                    ),
                      child: const Text("Finalizar Consulta"),
                    ),
                    
                ],
              ),
            ],
          ),
        ),),
    ));
  }

}