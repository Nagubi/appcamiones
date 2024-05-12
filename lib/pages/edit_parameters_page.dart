import 'package:appcamiones/pages/edit_card_page.dart';
import 'package:appcamiones/pages/edit_name_page.dart';
import 'package:appcamiones/pages/edit_phone_page.dart';
import 'package:appcamiones/pages/edit_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_or_register_page.dart';

class EditParametersScreen extends StatefulWidget {
  const EditParametersScreen({Key? key});

  @override
  State<EditParametersScreen> createState() => _EditParametersScreenState();
}

class _EditParametersScreenState extends State<EditParametersScreen> {
  final _newValueController = TextEditingController();

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginOrRegisterPage(),
      ),
    );
  }

  Future<void> editperfil(BuildContext context) async {
    CircularProgressIndicator();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(),
      ),
    );
  }

  void route() async {
    var collection = FirebaseFirestore.instance.collection('Perfil');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      //print(data['email'] );
      if (firebaseUser!.email == data['email']) {
        telefono = data['Telefono'].toString();
        correo = data['email'].toString();
        nombre = data['Nombre'].toString();
        tarjeta = data['Tarjeta'].toString();
        print(firebaseUser!.email);
        print(telefono);
      }
    }
  }

  String telefono = '';
  String correo = '';
  String nombre = '';
  String tarjeta = '';
  final firebaseUser = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    _newValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Factores')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return Column(
                    children: snapshot.data!.docs.map((unitData) {
                      return Column(
                        children: [
                          itemProfile(unitData),
                          const SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(DocumentSnapshot unitData) {
    Map<String, dynamic> data = unitData.data() as Map<String, dynamic>;
    String unidad = data['Tipo de Unidad'] ?? '';
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: ThemeData(
          brightness: Brightness.light,
          hintColor: Colors.black,
        ),
        child: ExpansionTile(
          title: ListTile(
            title: Text(
              unidad,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            leading: Icon(
              Icons.directions_car,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey[200],
          children: [
            _buildParameterTile(
                'Administracion', data['Administracion'], unitData.id),
            _buildParameterTile(
                'CargaLaboral', data['CargaLaboral'], unitData.id),
            _buildParameterTile(
                'Depreciacion', data['Depreciacion'], unitData.id),
            _buildParameterTile(
                'DireccionOGOI', data['DireccionOGOI'], unitData.id),
            _buildParameterTile(
                'DiversosTransp', data['DiversosTransp'], unitData.id),
            _buildParameterTile(
                'Infraestructura', data['Infraestructura'], unitData.id),
            _buildParameterTile('Llantas', data['Llantas'], unitData.id),
            _buildParameterTile(
                'Mantenimiento', data['Mantenimiento'], unitData.id),
            _buildParameterTile(
                'PagoOperador', data['PagoOperador'], unitData.id),
            _buildParameterTile(
                'RastreoSatelital', data['RastreoSatelital'], unitData.id),
            _buildParameterTile('SeguroCaja', data['SeguroCaja'], unitData.id),
            _buildParameterTile(
                'SeguroTracto', data['SeguroTracto'], unitData.id),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterTile(String title, dynamic value, String unitId) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _newValueController
                      .clear(); // Clear the controller before showing the dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Actualizar Valor'),
                        content: TextFormField(
                          controller: _newValueController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}'))
                          ],
                          decoration: InputDecoration(
                            labelText: 'Nuevo Valor',
                          ),
                          onChanged: (newValue) {
                            // Handle input change if needed
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              double newValue =
                                  double.tryParse(_newValueController.text) ??
                                      0.0;
                              FirebaseFirestore.instance
                                  .collection('Factores')
                                  .doc(unitId)
                                  .update({title: newValue});
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Text('Actualizar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black,
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }
}
