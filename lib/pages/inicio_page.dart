import 'package:appcamiones/pages/calculo_page_1.dart';
//import 'package:appcamiones/pages/home_page.dart';
import 'package:appcamiones/pages/perfil_page.dart';
import 'package:appcamiones/pages/usuario_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex=0;
  final user = FirebaseAuth.instance.currentUser!;
  String telefono="No tiene";
  @override
      
  Widget build(BuildContext context) {
    route(user.email.toString());
    final colors = Theme.of(context).colorScheme;
    final screens = [ /*HomePage(),*/ const ModalNuevoViaje1(),const UserPage(),  ProfileScreen(telefono:telefono)];
    
    return Scaffold(
      
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            activeIcon: Icon(Icons.monetization_on),
            label: 'Calculo',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history_outlined),
            label: 'Historial',
            backgroundColor: Colors.black,
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Colors.black,
          ),*/
          
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined),
            activeIcon: Icon(Icons.person_3),
            label: 'Perfil',
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
  void route(String? factor) async {
    var collection = FirebaseFirestore.instance.collection('Telefono');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
       if(factor == data['email']){
        telefono=data['Telefono'];
       }else{
        telefono=user.phoneNumber.toString();
        if(telefono=="null"){
          telefono="No tiene";
        }
       }
    }
  }
}