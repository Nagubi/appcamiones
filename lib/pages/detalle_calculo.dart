import 'package:appcamiones/pages/inicio_page.dart';
import 'package:appcamiones/pages/resultado_calculo_1.dart';
import 'package:flutter/material.dart';

class DetalleCalculo extends StatefulWidget {
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

  DetalleCalculo({
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
  State<DetalleCalculo> createState() => _DetalleCalculoState();
}

class _DetalleCalculoState extends State<DetalleCalculo> {
  double tarifaFinal = 0;
  double costoFinal = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.tarifaDolares == 0) {
      tarifaFinal = widget.tarifa;
    } else {
      tarifaFinal = widget.tarifaDolares;
    }

    if (widget.costoDolares == 0) {
      costoFinal = widget.costo;
    } else {
      costoFinal = widget.costoDolares;
    }

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
                _buildDetailCard("Fecha", widget.fecha, Icons.date_range),
                _buildDetailCard("Origen", widget.origen, Icons.location_on),
                _buildDetailCard("Destino", widget.destino, Icons.flag),
                _buildDetailCard("Tipo de Operación", widget.tipoOperacion, Icons.business),
                _buildDetailCard("Tipo de Unidad", widget.tipoUnidad, Icons.local_shipping),
                _buildDetailCard("Tipo de Viaje", widget.tipoViaje, Icons.local_shipping),
                _buildDetailCard("Precio del Diesel", "\$${widget.precioDiesel}", Icons.local_gas_station),
                _buildDetailCard("Tipo de Cambio", widget.tipoCambio, Icons.attach_money),
                _buildDetailCard("Kilómetros", widget.kilometros.toString(), Icons.route),
                _buildDetailCard("Costo", "\$${costoFinal.toString()}", Icons.money_off),
                _buildDetailCard("Utilidad", "${((widget.utilidad * 100) - 100).toStringAsFixed(0)}%", Icons.trending_up),
                _buildDetailCard("Tarifa", "\$${tarifaFinal.toString()}", Icons.attach_money),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildStyledButton(
                        context,
                        icon: Icons.arrow_back,
                        label: "Regresar",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CalculoResultado(
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
                        icon: Icons.exit_to_app,
                        label: "Finalizar Consulta",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Finalizar Consulta"),
                              content: Text('¿Seguro que desea finalizar la consulta?'),
                              actions: [
                                TextButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: new Text("Sí"),
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
