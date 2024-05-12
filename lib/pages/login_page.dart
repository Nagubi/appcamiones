import 'package:appcamiones/components/square_tile.dart';
import 'package:appcamiones/pages/forgot_password_page.dart';
import 'package:appcamiones/pages/inicio_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appcamiones/components/my_button.dart';
import 'package:appcamiones/components/my_textfield.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget {
  final Function() onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   bool _obscureText = true;
  void route() {
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  MainScreen(),
          ),
        );
  }
/*// sign user in method
  void signUserIn() async{
    //mostrar circulo de carga
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //intentar inicio de sesion
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    //dejar de mostrar simbolo de carga

      

    } on FirebaseAuthException catch (e){

      //dejar de mostrar simbolo de carga
      Navigator.pop(context);

      //mostrar mensaje de error
      showErrorMessage(e.code);
    }
  }*/
  void signIn() async {
      try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showErrorMessage('Usuario no encontrado');
        } else if (e.code == 'wrong-password') {
          showErrorMessage('Contraseña incorrecta');
        } 
      }
  }
   signInWithGoogle() async {
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  //obtener los detalles de autorizacion de la peticion
  final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  //crear nueva credencial para el usuario
  final credential = GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken,
  );

  //finalmente vamos a iniciar sesion
  try {
    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    
    // Check if the authentication was successful and user is not null
    if (authResult != null && authResult.user != null) {
      await _saveEmailToCollection(authResult.user!);
      route(); // Assuming route() is your navigation function
    } else {
      print('Error signing in with Google: User not found');
    }
  } catch (e) {
    print('Error signing in with Google: $e');
  }
}

  Future<void> _saveEmailToCollection(User user) async {
     try {
    // Access the current user's email
    String? email = user.email;

    // Check if the email already exists in the collection
    final QuerySnapshot existingEmails = await _firestore
        .collection('Perfil')
        .where('email', isEqualTo: email)
        .get();

    if (existingEmails.docs.isEmpty) {
      // Email doesn't exist, so add it to the collection
      await _firestore.collection('Perfil').doc(email).set({
        'email': email,
      });

      print('Email saved successfully: $email');
    } else {
      print('Email already exists: $email');
    }
  } catch (e) {
    print('Error saving email: $e');
  }
  }

  //ErrorCorreoOcontrasena
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ), 
        );
      },
    );
  }
  


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child:Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
          
                // logo
                const CircleAvatar(
                  backgroundImage: AssetImage('lib/images/logocamion.png'),
                  radius: 60,
                ),
          
                const SizedBox(height: 10),
          
                // welcome back, you've been missed!
                Text(
                  'Bienvenido a calculo de tarifas',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 10),
          
                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Correo Electronico',
                  obscureText: false,
                ),
          
                const SizedBox(height: 15),
          
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: _obscureText,
                ),
          
                const SizedBox(height: 10),
          
                // forgot password?
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    
                    
                    children: [
                      SizedBox(
                        height: 40,
                        width: 200,
                        child:  CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Mostrar Contraseña"),
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        value: !_obscureText, onChanged:(onTap){setState(() {
                            _obscureText = !_obscureText;
                          });} ),
                       ),
                      
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context){
                                return const ForgotPasswordPage();
                              },
                            )
                          );
                        },
                        child: const Text(
                          'Olvido su contraseña?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // sign in button
                MyButton(
                  text: "Iniciar Sesion",
                  onTap: signIn,
                ),
          
                const SizedBox(height: 25),
          
                // or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'O continuar con',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 30),
          
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: signInWithGoogle,
                      imagePath: 'lib/images/google.png'
                    ),
                    
                    SizedBox(width: 20),
          
                  ],
                ),
          
                const SizedBox(height: 30),
          
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No eres usuario?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Registrate ahora',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}