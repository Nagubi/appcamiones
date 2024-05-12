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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String telefono = '';
  String correo = '';
  String nombre = '';
  String tarjeta = '';
  final firebaseUser = FirebaseAuth.instance.currentUser!;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    route(); // Llamamos a la función route una vez en el initState
  }

  Future<void> route() async {
    var collection = FirebaseFirestore.instance.collection('Perfil');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (firebaseUser.email == data['email']) {
        if (mounted) { // Verificar si el widget aún está montado antes de llamar a setState()
          setState(() {
            telefono = data['Telefono'].toString();
            correo = data['email'].toString();
            nombre = data['Nombre'].toString();
            tarjeta = data['Tarjeta'].toString();
            _isLoading = false;
          });
        }
        print(firebaseUser.email);
        print(telefono);
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginOrRegisterPage(),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData, Widget data) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: const Color.fromARGB(255, 185, 179, 178).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => data,
              ),
            );
          },
        ),
        tileColor: Colors.white,
      ),
    );
  }

  Widget itemProfile2(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: const Color.fromARGB(255, 185, 179, 178).withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('lib/images/logocamion.png'),
                  ),
                  const SizedBox(height: 20),
                  itemProfile('Nombre', nombre, CupertinoIcons.person, EditNameScreen()),
                  const SizedBox(height: 10),
                  itemProfile('Telefono', telefono, CupertinoIcons.phone, EditPhoneScreen()),
                  const SizedBox(height: 10),
                  itemProfile('Numero de Tarjeta', tarjeta, CupertinoIcons.creditcard, EditCardScreen()),
                  const SizedBox(height: 10),
                  itemProfile2('Correo Electronico', correo, CupertinoIcons.mail),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Cerrar Sesion"),
                            content: Text('¿Seguro que deseas cerrar sesión?'),
                            actions: [
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Continuar"),
                                onPressed: () {
                                  logout(context);
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
                      child: const Text('Cerrar Sesion'),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

