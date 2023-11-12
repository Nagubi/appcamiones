import 'package:appcamiones/pages/login_or_register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  /*final _auth = FirebaseAuth.instance;
  String valor="";
  String rool = "Usuario";*/
  final usersRef = FirebaseFirestore.instance.collection('users');
  //sing user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    Navigator.pop(context);
  }
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
  @override
  Widget build(BuildContext context) {
    //postDetailsGoogleToFirestore(user.email!);
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
          "Sesion Conectada con:"+user.email!,
          style: TextStyle(fontSize: 20),
      ),
      ),
    ));
  }
  /*postDetailsGoogleToFirestore(String gUser)  async{
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    try {
       await FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((value) {valor =  value.get('rool');});
       if(valor=="Admin"){
      rool="Admin";
    }else {
        rool="Usuario";
    }
    await ref.doc(user.uid).set({'email': gUser, 'rool': rool});
    } on FirebaseFirestore catch (e){

       ref.doc(user!.uid).set({'email': gUser, 'rool': "Usuario"});
    }
   
    
 
      
  }*/
  
}