import 'package:appcamiones/pages/detalle_calculo.dart';
import 'package:appcamiones/pages/detalles_propuesta.dart';
import 'package:appcamiones/pages/inicio_page.dart';
import 'package:flutter/material.dart';


class CalculoResultado extends StatefulWidget{
   final String tipoViaje;
  final String tipoOperacion;
  final String tipoUnidad;
  final String origen;
  final String fecha;
  final String destino;
  final double tarifa;
  final double tarifaDolares;
  final double costoDolares;
  final double precioDiesel;
  final double kilometros;
  final double costo;
  final double utilidad;
   CalculoResultado({
    super.key,
    required this.tipoViaje,
    required this.tipoOperacion,
    required this.tipoUnidad,
    required this.origen,
    required this.fecha,
    required this.destino,
    required this.tarifa,
    required this.tarifaDolares,
    required this.precioDiesel,
    required this.kilometros,
    required this.costo,
    required this.costoDolares,
    required this.utilidad,
  });
  @override
  State<CalculoResultado> createState() => _CalculoResultadoState();

}

class _CalculoResultadoState extends State<CalculoResultado>{
  double tarifaFinal=0;
  String tipomoneda="";
  @override
  Widget build(BuildContext context){
      if(widget.tarifaDolares==0){
        tarifaFinal=widget.tarifa;
        tipomoneda="Pesos";
      }else{
        tarifaFinal=widget.tarifaDolares;
        tipomoneda="Dolares";
      };
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
    child: Scaffold(
      backgroundColor: Color.fromARGB(218, 229, 226, 226),
      appBar: AppBar(
        title: Text('Resultado del Calculo'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        elevation: 0.0,
      ),
      floatingActionButton: Wrap(direction: Axis.horizontal, //use vertical to show  on vertical axis
                  children: [
                        Container( 
                          margin:EdgeInsets.all(2),
                          child: FloatingActionButton.extended(
                            heroTag: null,
                            label: Text('Finalizar Consulta'), // <-- Text
                            backgroundColor: Colors.black,
                            onPressed: () {showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Finalizar Consulta"),
                      content: Text('Seguro que desea Finalizar la Consulta?'),
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
                      ));},
                            
                          )
                        ),
                ],
            ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
              "Fecha de Tarifa:",
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

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
              "Tarifa en $tipomoneda:\$ ",
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              ),
                Text(
              tarifaFinal.toString(),
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                ),
              ),
              ],),
              Row(children: [
                ElevatedButton(
                onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleCalculo(tipoViaje: widget.tipoViaje,tipoOperacion: widget.tipoOperacion,tipoUnidad: widget.tipoUnidad,tarifa: widget.tarifa,origen: widget.origen,
                        destino: widget.destino,fecha:widget.fecha ,tarifaDolares: widget.tarifaDolares,
                        precioDiesel: widget.precioDiesel,utilidad: widget.utilidad,kilometros: widget.kilometros,costo: widget.costo,costoDolares: widget.costoDolares,tipoCambio: tipomoneda,),
                      ),
                    );
                    
                },
                style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(15),
                    ),
                child: const Text("Detalle del Calculo"),
              ),
              SizedBox(width: 5,),
              ElevatedButton(
                onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallePropuesta(tipoViaje: widget.tipoViaje,tipoOperacion: widget.tipoOperacion,tipoUnidad: widget.tipoUnidad,tarifa: widget.tarifa,origen: widget.origen,
                        destino: widget.destino,fecha:widget.fecha ,tarifaDolares: widget.tarifaDolares,
                        precioDiesel: widget.precioDiesel,utilidad: widget.utilidad,kilometros: widget.kilometros,costo: widget.costo,costoDolares: widget.costoDolares,tipoCambio: tipomoneda,),
                      ),
                    );
                    
                },
                style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(15),
                    ),
                child: const Text("Propuesta %"),
              ),
              ],),
            ],
          ),
        ),),
    ));
  }

}