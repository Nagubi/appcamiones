import 'package:appcamiones/components/my_button.dart';
import 'package:appcamiones/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super (key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content : Text('Enlace de restablecimiento enviado cheque su correo electronico!'),
          );
        },
      );
    }on FirebaseAuthException catch(e) {
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content : Text(e.message.toString()),
          );
        },
      );
    }
  }
  

  @override
  Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 63, 59, 59),
          elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'Ingresa tu direccion de correo electronico y te enviaremos un enlace de recuperacion de contraseña',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                  ),
              ),
              const SizedBox(height: 10),
              // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Correo Electronico',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyButton(
                  text: "Reiniciar Contraseña",
                  onTap: passwordReset,
                ),
            ],
          )

      );
  }
}
