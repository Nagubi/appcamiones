import 'package:appcamiones/pages/calculo_page_1.dart';
import 'package:appcamiones/pages/leer_viaje.dart';
import 'package:appcamiones/pages/login_or_register_page.dart';
import 'package:appcamiones/pages/viajes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'nuevo_viaje_page.dart';


class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
          title: Text('Historial Viajes'),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("Viajes").where("Usuario", isEqualTo: user.email.toString()).snapshots(),
                        builder: (context, AsyncSnapshot snapshot){
                          if(snapshot.connectionState== ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }else{
                            if(snapshot.hasData){
                            return GridView(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 420,
                              childAspectRatio: 3.2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10),
                              children: snapshot.data!.docs.map<Widget>((viaje)=> visionViaje((){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LeerViajeScreen(viaje),));
                              },viaje)).toList(),
                            );
                            
                          }else{
                            return Text("no hay viajes",style: TextStyle(fontSize: 20));
                          }
                          }
                          
                           

                        }
                    
                      ),
                    )
                  ],
                ),
          ),
        ));
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
  
  Future<void> NuevoViaje(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ModalNuevoViaje(),
      ),
    );
  }
}