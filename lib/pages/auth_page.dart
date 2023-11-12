
import 'package:appcamiones/pages/inicio_page.dart';
import 'package:appcamiones/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {

   AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,  snapshot  ){
          if (snapshot.hasData){
              return MainScreen();
          //user is NOT logged in
          }else{
            return LoginOrRegisterPage();
          }
        } 
      ),
    );
  }

}
/*class AuthPage extends StatefulWidget {
  AuthPage({super.key});

   State<AuthPage> createState() => _AuthPageState();
  }
  class _AuthPageState extends State<AuthPage> {
    final _auth = FirebaseAuth.instance;
  
    String valor="";

    Widget build(BuildContext context) {
      return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            //user is logged in
            if (snapshot.hasData){
              
              CollectionReference ref = FirebaseFirestore.instance.collection('users');
              FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((value) {valor =  value.get('rool');});
        
              if(valor=="Admin"){
            
              }
            }
            //user is NOT logged in
            else{
              return LoginOrRegisterPage();
            }
          } 
        ),
      );
    }
  }*/
  

