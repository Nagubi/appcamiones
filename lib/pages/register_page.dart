//import 'package:appcamiones/services/auth_services.dart';
import 'package:appcamiones/components/square_tile.dart';
import 'package:appcamiones/pages/inicio_page.dart';
import 'package:appcamiones/pages/login_or_register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:appcamiones/pages/usuario_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appcamiones/components/my_button.dart';
import 'package:appcamiones/components/my_textfield.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:appcamiones/components/square_tile.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final telefonoController = TextEditingController();
  final nombreController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance; 
//register with email & password & save username instantly
Future registerWithEmailAndPassword(String name, String password, String email,String number) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user!;
    await FirebaseFirestore.instance.collection('Telefono').add({'Telefono':number,'email':email});
    user.updateDisplayName(name); //added this line
    //user.updatePhoneNumber(number as PhoneAuthCredential); //added this line
    return CreadoConexito();
  } catch(e) {
    Navigator.pop(context);

          //mostrar mensaje de error
          showErrorMessage(e.toString());
    return null;
  }
}
  void route() {
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  MainScreen(),
          ),
        );
  }
  bool validarCampo(String value) {
    if (value.isNotEmpty) {
      return false;
    }
    return true;
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
    
     await FirebaseAuth.instance.signInWithCredential(credential).then((value) => route());
    
  }
  // Registrar usuario
  void signUserUp() async{
    //mostrar circulo de carga
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //intentar registrar usuario
      

      if (passwordController.text != confirmPasswordController.text && validarCampo(telefonoController.text) &&validarCampo(nombreController.text)) {
        Navigator.pop(context);
        //mostrar mensaje de error
        showErrorMessage("No coinciden las contraseñas");
        return;
      } 
      else{
        /*await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);*/
        try {

           await registerWithEmailAndPassword( nombreController.text, passwordController.text, emailController.text,telefonoController.text);
        //dejar de mostrar simbolo de carga
        
          

        } on FirebaseAuthException catch (e){

          //dejar de mostrar simbolo de carga
          Navigator.pop(context);

          //mostrar mensaje de error
          showErrorMessage(e.code);
        }
      }
    //dejar de mostrar simbolo de carga

      

     
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
        child: Scaffold(
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
                  radius: 40,
                ),
          
                const SizedBox(height: 10),
          
                // welcome back, you've been missed!
                Text(
                  'Vamos a crear una cuenta nueva',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 20),
          
                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Correo Electronico',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
                //Nombre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: nombreController,
                    obscureText: false,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Nombre",
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                ),
                const SizedBox(height: 10),
                //Telefono
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: telefonoController,
                    obscureText: false,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Telefono",
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
                ),
                
          
                const SizedBox(height: 10),
                // password textfield
               MyTextField(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: _obscureText,
                ),
                
                
          
                const SizedBox(height: 10),

                // confirmar password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirmar contraseña',
                  obscureText: _obscureText,
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text("Mostrar Contraseñas"),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  value: !_obscureText, onChanged:(onTap){setState(() {
                      _obscureText = !_obscureText;
                    });} ),
                
                
      
                // sign in button
                MyButton(
                  text: "Registrar Cuenta",
                  onTap: signUserUp,
                ),
          
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
                      'Si ya tiene una cuenta',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Iniciar Sesion',
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
  CreadoConexito() async {
    showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Cuenta Creada"),
                content: Text('Su cuenta fue creada con exito por favor inicie sesion'),
                actions: [
                  TextButton(
                    child: Text("Aceptar"),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginOrRegisterPage(),
                        ),
                      );
                    },
                  ),
                  
                   
                ],
                ));
    
  }
  
}