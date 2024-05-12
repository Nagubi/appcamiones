/*import 'package:appcamiones/pages/calculo_page_1.dart';
import 'package:appcamiones/pages/edit_parameters_page.dart';
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
  String telefono = "No tiene";
  String admin = '0';
  final firebaseUser = FirebaseAuth.instance.currentUser!;

void route() async {
    var collection = FirebaseFirestore.instance.collection('Perfil');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      //print(data['email'] );
       if(firebaseUser!.email == data['email']){
        admin=data['Admin'].toString();
        print(firebaseUser!.email);
        print(telefono);
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    route();
    final colors = Theme.of(context).colorScheme;
    final screens = [ /*HomePage(),*/ const ModalNuevoViaje1(),const UserPage(),  if (admin == '1') const EditParametersScreen(),ProfileScreen() ];
    
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings),
            label: 'Configuracion',
            backgroundColor: Colors.black,
          ),
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
}*/


import 'package:appcamiones/pages/calculo_page_1.dart';
import 'package:appcamiones/pages/edit_parameters_page.dart';
//import 'package:appcamiones/pages/home_page.dart';
import 'package:appcamiones/pages/perfil_page.dart';
import 'package:appcamiones/pages/usuario_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  String telefono = "No tiene";
  String admin = '0'; // Assuming '0' indicates non-admin user
  final firebaseUser = FirebaseAuth.instance.currentUser!;

  Future<String> fetchAdminStatus() async {
    var collection = FirebaseFirestore.instance.collection('Perfil');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (firebaseUser.email == data['email']) {
        return data['Admin'].toString();
      }
    }
    return '0';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screens = [
      /*HomePage(),*/
      const ModalNuevoViaje1(),
      const UserPage(),
      if (admin == '1') const EditParametersScreen(), // Show EditParametersScreen only if admin status is '1'
      const ProfileScreen(),
    ];

    return FutureBuilder<String>(
      future: fetchAdminStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        admin = snapshot.data ?? '0';
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
            items: admin == '1'
                ? [
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
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      activeIcon: Icon(Icons.settings),
                      label: 'Configuracion',
                      backgroundColor: Colors.black,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_3_outlined),
                      activeIcon: Icon(Icons.person_3),
                      label: 'Perfil',
                      backgroundColor: Colors.black,
                    ),
                  ]
                : [
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
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_3_outlined),
                      activeIcon: Icon(Icons.person_3),
                      label: 'Perfil',
                      backgroundColor: Colors.black,
                    ),
                  ],
          ),
        );
      },
    );
  }
}