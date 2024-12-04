import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LeerViajeScreen extends StatefulWidget {
  LeerViajeScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<LeerViajeScreen> createState() => _LeerViajeScreenState();
}

class _LeerViajeScreenState extends State<LeerViajeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 229, 226, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: _generatePdf,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpansionTile(
                title: "Generales de la Tarifa",
                children: [
                  _buildDetailCard("Fecha de Tarifa", widget.doc.get("Fecha de Tarifa"), Icons.date_range),
                  _buildDetailCard("Origen", widget.doc.get("Origen"), Icons.location_on),
                  _buildDetailCard("Destino", widget.doc.get("Destino"), Icons.flag),
                  _buildDetailCard("Tipo de Operacion", widget.doc.get("Tipo de Operacion"), Icons.business),
                  _buildDetailCard("Tipo de Viaje", widget.doc.get("Tipo de Viaje"), Icons.local_shipping),
                  _buildDetailCard("Tipo de Unidad", widget.doc.get("Tipo de Unidad"), Icons.local_shipping),
                ],
              ),
              _buildExpansionTile(
                title: "Resultado",
                children: [
                  _buildDetailCard("Utilidad", "${widget.doc.get("Utilidad")}%"),
                  _buildDetailCard("Tarifa Dolares", "\$${widget.doc.get("Tarifa Dolares").toString()}", Icons.attach_money),
                  _buildDetailCard("Costo Dolares", "\$${widget.doc.get("Costo Dolares").toString()}", Icons.attach_money),
                  _buildDetailCard("Tarifa", "\$${widget.doc.get("Tarifa").toString()}", Icons.money),
                  _buildDetailCard("Costo", "\$${widget.doc.get("Costo").toString()}", Icons.money),
                ],
              ),
              _buildExpansionTile(
                title: "Factores",
                children: [
                  _buildDetailCard("Costo Recolecciones", "\$${widget.doc.get("Costo Recolecciones").toString()}", Icons.local_shipping),
                  _buildDetailCard("Transfer", "\$${widget.doc.get("Transfer").toString()}", Icons.swap_horiz),
                  _buildDetailCard("Kilómetros", widget.doc.get("Kilómetros"), Icons.route),
                  _buildDetailCard("Días Viaje", widget.doc.get("Días Viaje"), Icons.calendar_today),
                  _buildDetailCard("Casetas", "\$${widget.doc.get("Casetas")}"),
                  _buildDetailCard("Precio del Diesel", "\$${widget.doc.get("Precio del Diesel")}"),
                  _buildDetailCard("Rendimiento Tracto", widget.doc.get("Rendimiento Tracto"), Icons.speed),
                  _buildDetailCard("Litros Diesel Thermo", widget.doc.get("Litros Diesel Thermo").toString(), Icons.local_gas_station),
                ],
              ),
              _buildExpansionTile(
                title: "Datos Operativos",
                children: [
                  _buildDetailCard("Pago Operador", "\$${widget.doc.get("Pago Operador").toString()}", Icons.payment),
                  _buildDetailCard("Diesel", "\$${widget.doc.get("Diesel").toString()}", Icons.local_gas_station),
                  _buildDetailCard("Diesel Thermo", "\$${widget.doc.get("Diesel  Thermo").toString()}", Icons.local_gas_station),
                  _buildDetailCard("Carga Laboral", "\$${widget.doc.get("Carga Laboral").toString()}", Icons.work),
                  _buildDetailCard("Mantenimiento", "\$${widget.doc.get("Mantenimiento").toString()}", Icons.build),
                  _buildDetailCard("Llantas", "\$${widget.doc.get("Llantas").toString()}", Icons.directions_car),
                  _buildDetailCard("Seguro Tracto", "\$${widget.doc.get("Seguro Tracto").toString()}", Icons.security),
                  _buildDetailCard("Seguro Caja", "\$${widget.doc.get("Seguro Caja").toString()}", Icons.security),
                  _buildDetailCard("Depreciación", "\$${widget.doc.get("Depreciación").toString()}", Icons.trending_down),
                  _buildDetailCard("Rastreo Satelital", "\$${widget.doc.get("Rasteo Satelital").toString()}", Icons.satellite),
                  _buildDetailCard("Diversos Transp.", "\$${widget.doc.get("Diversos Transp").toString()}", Icons.miscellaneous_services),
                  _buildDetailCard("Administración", "\$${widget.doc.get("Administración").toString()}", Icons.admin_panel_settings),
                  _buildDetailCard("Infraestructura", "\$${widget.doc.get("Infraestructura").toString()}", Icons.foundation),
                  _buildDetailCard("Direccion OGOI", "\$${widget.doc.get("Direccion OGOI").toString()}", Icons.directions),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          _buildPdfSection("Generales de la Tarifa", [
            ["Fecha de Tarifa", widget.doc.get("Fecha de Tarifa")],
            ["Origen", widget.doc.get("Origen")],
            ["Destino", widget.doc.get("Destino")],
            ["Tipo de Operacion", widget.doc.get("Tipo de Operacion")],
            ["Tipo de Viaje", widget.doc.get("Tipo de Viaje")],
            ["Tipo de Unidad", widget.doc.get("Tipo de Unidad")],
          ]),
          _buildPdfSection("Resultado", [
            ["Utilidad", "${widget.doc.get("Utilidad")}%"],
            ["Tarifa Dolares", "\$${widget.doc.get("Tarifa Dolares").toString()}"],
            ["Costo Dolares", "\$${widget.doc.get("Costo Dolares").toString()}"],
            ["Tarifa", "\$${widget.doc.get("Tarifa").toString()}"],
            ["Costo", "\$${widget.doc.get("Costo").toString()}"],
          ]),
          _buildPdfSection("Factores", [
            ["Costo Recolecciones", "\$${widget.doc.get("Costo Recolecciones").toString()}"],
            ["Transfer", "\$${widget.doc.get("Transfer").toString()}"],
            ["Kilómetros", widget.doc.get("Kilómetros")],
            ["Días Viaje", widget.doc.get("Días Viaje")],
            ["Casetas", "\$${widget.doc.get("Casetas")}"],
            ["Precio del Diesel", "\$${widget.doc.get("Precio del Diesel")}"],
            ["Rendimiento Tracto", widget.doc.get("Rendimiento Tracto")],
            ["Litros Diesel Thermo", "\$${widget.doc.get("Litros Diesel Thermo").toString()}"],
          ]),
          _buildPdfSection("Datos Operativos", [
            ["Pago Operador", "\$${widget.doc.get("Pago Operador").toString()}"],
            ["Diesel", "\$${widget.doc.get("Diesel").toString()}"],
            ["Diesel Thermo", "\$${widget.doc.get("Diesel  Thermo").toString()}"],
            ["Carga Laboral", "\$${widget.doc.get("Carga Laboral").toString()}"],
            ["Mantenimiento", "\$${widget.doc.get("Mantenimiento").toString()}"],
            ["Llantas", "\$${widget.doc.get("Llantas").toString()}"],
            ["Seguro Tracto", "\$${widget.doc.get("Seguro Tracto").toString()}"],
            ["Seguro Caja", "\$${widget.doc.get("Seguro Caja").toString()}"],
            ["Depreciación", "\$${widget.doc.get("Depreciación").toString()}"],
            ["Rastreo Satelital", "\$${widget.doc.get("Rasteo Satelital").toString()}"],
            ["Diversos Transp.", "\$${widget.doc.get("Diversos Transp").toString()}"],
            ["Administración", "\$${widget.doc.get("Administración").toString()}"],
            ["Infraestructura", "\$${widget.doc.get("Infraestructura").toString()}"],
            ["Direccion OGOI", "\$${widget.doc.get("Direccion OGOI").toString()}"],
          ]),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _buildPdfSection(String title, List<List<String>> details) {
    return pw.Container(
      child: pw.Wrap(
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.TableHelper.fromTextArray(
            headers: ['Campo', 'Valor'],
            data: details,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: pw.TextStyle(fontSize: 12),
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              color: PdfColors.grey300,
            ),
            cellHeight: 30,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerRight,
            },
          ),
          pw.SizedBox(height: 16),
        ],
      ),
    );
  }

  Card _buildExpansionTile({required String title, required List<Widget> children}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        backgroundColor: Colors.grey[200],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        children: children,
      ),
    );
  }

  Card _buildDetailCard(String title, String value, [IconData? icon]) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 30, color: Colors.black),
            if (icon != null) SizedBox(width: 10),
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
}







/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeerViajeScreen extends StatefulWidget {
  LeerViajeScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<LeerViajeScreen> createState() => _LeerViajeScreenState();
}

class _LeerViajeScreenState extends State<LeerViajeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 229, 226, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpansionTile(
                title: "Generales de la Tarifa",
                children: [
                  _buildDetailCard("Fecha de Tarifa", widget.doc["Fecha de Tarifa"], Icons.date_range),
                  _buildDetailCard("Origen", widget.doc["Origen"], Icons.location_on),
                  _buildDetailCard("Destino", widget.doc["Destino"], Icons.flag),
                  _buildDetailCard("Tipo de Operacion", widget.doc["Tipo de Operacion"], Icons.business),
                  _buildDetailCard("Tipo de Viaje", widget.doc["Tipo de Viaje"], Icons.local_shipping),
                  _buildDetailCard("Tipo de Unidad", widget.doc["Tipo de Unidad"], Icons.local_shipping),
                ],
              ),
              _buildExpansionTile(
                title: "Resultado",
                children: [
                  _buildDetailCard("Utilidad", "${widget.doc["Utilidad"]}%", Icons.bar_chart),
                  _buildDetailCard("Tarifa Dolares", widget.doc["Tarifa Dolares"].toString(), Icons.attach_money),
                  _buildDetailCard("Costo Dolares", widget.doc["Costo Dolares"].toString(), Icons.attach_money),
                  _buildDetailCard("Tarifa", widget.doc["Tarifa"].toString(), Icons.money),
                  _buildDetailCard("Costo", widget.doc["Costo"].toString(), Icons.money),
                ],
              ),
              _buildExpansionTile(
                title: "Factores",
                children: [
                  _buildDetailCard("Costo Recolecciones", widget.doc["Costo Recolecciones"].toString(), Icons.local_shipping),
                  _buildDetailCard("Transfer", widget.doc["Transfer"].toString(), Icons.swap_horiz),
                  _buildDetailCard("Kilómetros", widget.doc["Kilómetros"], Icons.route),
                  _buildDetailCard("Días Viaje", widget.doc["Días Viaje"], Icons.calendar_today),
                  _buildDetailCard("Casetas", widget.doc["Casetas"], Icons.local_taxi),
                  _buildDetailCard("Precio del Diesel", widget.doc["Precio del Diesel"], Icons.local_gas_station),
                  _buildDetailCard("Rendimiento Tracto", widget.doc["Rendimiento Tracto"], Icons.speed),
                  _buildDetailCard("Litros Diesel Thermo", widget.doc["Litros Diesel Thermo"].toString(), Icons.local_gas_station),
                ],
              ),
              _buildExpansionTile(
                title: "Datos Operativos",
                children: [
                  _buildDetailCard("Pago Operador", widget.doc["Pago Operador"].toString(), Icons.payment),
                  _buildDetailCard("Diesel", widget.doc["Diesel"].toString(), Icons.local_gas_station),
                  _buildDetailCard("Diesel Thermo", widget.doc["Diesel  Thermo"].toString(), Icons.local_gas_station),
                  _buildDetailCard("Carga Laboral", widget.doc["Carga Laboral"].toString(), Icons.work),
                  _buildDetailCard("Mantenimiento", widget.doc["Mantenimiento"].toString(), Icons.build),
                  _buildDetailCard("Llantas", widget.doc["Llantas"].toString(), Icons.directions_car),
                  _buildDetailCard("Seguro Tracto", widget.doc["Seguro Tracto"].toString(), Icons.security),
                  _buildDetailCard("Seguro Caja", widget.doc["Seguro Caja"].toString(), Icons.security),
                  _buildDetailCard("Depreciación", widget.doc["Depreciación"].toString(), Icons.trending_down),
                  _buildDetailCard("Rastreo Satelital", widget.doc["Rasteo Satelital"].toString(), Icons.satellite),
                  _buildDetailCard("Diversos Transp.", widget.doc["Diversos Transp"].toString(), Icons.miscellaneous_services),
                  _buildDetailCard("Administración", widget.doc["Administración"].toString(), Icons.admin_panel_settings),
                  _buildDetailCard("Infraestructura", widget.doc["Infraestructura"].toString(), Icons.foundation),
                  _buildDetailCard("Direccion OGOI", widget.doc["Direccion OGOI"].toString(), Icons.directions),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile({required String title, required List<Widget> children}) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ExpansionTile(
      backgroundColor: Colors.grey[200], // Set background color to grey
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      children: children,
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
}*/
