import 'package:appcamiones/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
  return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child:Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        actions:[
            IconButton(onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Cerrar Sesion"),
                content: Text('Seguro que deseas cerrar sesion?'),
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
                      logout(context);
                    },
                  ),
                   
                ],
                ),
              ),
              icon: Icon(Icons.logout),
           )
          
        ],
      ),
      body: Center(
        child: Text(
          "Sesion Conectada con:"+user.email!+" Admin",
          style: TextStyle(fontSize: 20),
      ),
      ),
    ));
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginOrRegisterPage(),
      ),
    );
  }
}