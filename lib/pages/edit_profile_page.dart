import 'package:appcamiones/pages/inicio_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  
  Future<void> profile(BuildContext context) async {
    CircularProgressIndicator();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
  }

  void route() async {
    var collection = FirebaseFirestore.instance.collection('Perfil');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      //print(data['email'] );
       if(firebaseUser!.email == data['email']){
        telefono=data['Telefono'].toString();
        correo=data['email'].toString();
        nombre=data['Nombre'].toString();
        print('xd' + firebaseUser!.email.toString());
        print(telefono);
       }
    }
  }

  String telefono = '';
  String correo = '';
  String nombre = '';
  final firebaseUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    print(nombre);
    route();
    print(telefono);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('lib/images/logocamion.png'),
            ),
            const SizedBox(height: 20),
            itemProfile('Nombre', nombre, CupertinoIcons.person),
            const SizedBox(height: 10),
            //itemProfile('Telefono', widget.telefono, CupertinoIcons.phone),
            itemProfile('Telefono',telefono, CupertinoIcons.phone),
            const SizedBox(height: 10),
            itemProfile('Correo Electronico', correo, CupertinoIcons.mail),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Guardar Cambios"),
                  content: Text('Seguro que deseas guardar los cambios realizados?'),
                  actions: [
                    TextButton(
                      child: Text("Cancelar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: new Text("Continuar"),
                      onPressed: () {
                        profile(context);
                      },
                    ),
                    
                  ],
                  ),
                );},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Guardar Cambios')
              ),
            )
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
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
}