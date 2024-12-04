import 'package:appcamiones/pages/detalle_calculo.dart';
import 'package:appcamiones/pages/detalles_propuesta.dart';
import 'package:appcamiones/pages/inicio_page.dart';
import 'package:flutter/material.dart';

class CalculoResultado extends StatefulWidget {
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

class _CalculoResultadoState extends State<CalculoResultado> {
  double tarifaFinal = 0;
  String tipomoneda = "";

  @override
  Widget build(BuildContext context) {
    if (widget.tarifaDolares == 0) {
      tarifaFinal = widget.tarifa;
      tipomoneda = "Pesos";
    } else {
      tarifaFinal = widget.tarifaDolares;
      tipomoneda = "Dolares";
    }

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
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailCard(
                    "Fecha de Tarifa", widget.fecha, Icons.date_range),
                _buildDetailCard("Origen", widget.origen, Icons.location_on),
                _buildDetailCard("Destino", widget.destino, Icons.flag),
                _buildDetailCard("Tipo de Operacion", widget.tipoOperacion,
                    Icons.business),
                _buildDetailCard(
                    "Tipo de Unidad", widget.tipoUnidad, Icons.local_shipping),
                _buildDetailCard(
                    "Tipo de Viaje", widget.tipoViaje, Icons.local_shipping),
                _buildDetailCard("Tarifa en $tipomoneda",
                    "\$${tarifaFinal.toString()}", Icons.attach_money),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildStyledButton(
                        context,
                        icon: Icons.calculate,
                        label: "Detalle del Calculo",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleCalculo(
                                tipoViaje: widget.tipoViaje,
                                tipoOperacion: widget.tipoOperacion,
                                tipoUnidad: widget.tipoUnidad,
                                tarifa: widget.tarifa,
                                origen: widget.origen,
                                destino: widget.destino,
                                fecha: widget.fecha,
                                tarifaDolares: widget.tarifaDolares,
                                precioDiesel: widget.precioDiesel,
                                utilidad: widget.utilidad,
                                kilometros: widget.kilometros,
                                costo: widget.costo,
                                costoDolares: widget.costoDolares,
                                tipoCambio: tipomoneda,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildStyledButton(
                        context,
                        icon: Icons.percent,
                        label: "Propuesta %",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallePropuesta(
                                tipoViaje: widget.tipoViaje,
                                tipoOperacion: widget.tipoOperacion,
                                tipoUnidad: widget.tipoUnidad,
                                tarifa: widget.tarifa,
                                origen: widget.origen,
                                destino: widget.destino,
                                fecha: widget.fecha,
                                tarifaDolares: widget.tarifaDolares,
                                precioDiesel: widget.precioDiesel,
                                utilidad: widget.utilidad,
                                kilometros: widget.kilometros,
                                costo: widget.costo,
                                costoDolares: widget.costoDolares,
                                tipoCambio: tipomoneda,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: _buildStyledButton(
                    context,
                    icon: Icons.exit_to_app,
                    label: "Finalizar Consulta",
                    onPressed: () {
                      showDialog(
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.black),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(label, style: TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}




