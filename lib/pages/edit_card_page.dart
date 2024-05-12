import 'package:appcamiones/pages/inicio_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditCardScreen extends StatefulWidget {
  const EditCardScreen({super.key});

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  Future<String?> getEmail() async {
    try {
      // Check if the user is authenticated
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Access the user's email
        print(user.email.toString() + "xdxdxd");
        return user.email;
      } else {
        // If user is not authenticated, return null
        return null;
      }
    } catch (e) {
      // Handle error and return null
      print('Error retrieving user email: $e');
      return null;
    }
  }

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

  CreadoConexito() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cambio de Tarjeta Exitoso"),
        content: Text('Su número de tarjeta fue actualizado con éxito.'),
        actions: [
          TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future actualizarTarjeta(String tarjeta) async {
    try {
      String? email = await getEmail();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Assuming you have a 'Perfil' collection where each document has a field 'Email'
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Perfil')
            .where('email', isEqualTo: email)
            .get();

        // If the document with the specified email exists, update its card number
        if (querySnapshot.docs.isNotEmpty) {
          String documentId = querySnapshot.docs.first.id;
          await FirebaseFirestore.instance
              .collection('Perfil')
              .doc(documentId)
              .update({'Tarjeta': tarjeta});
          return CreadoConexito();
          // If the update is successful, print a success message
        } else {
          print(
              'No se encontró ningún usuario con el correo electrónico especificado');
          // Handle case where user document doesn't exist
        }
      } else {
        print('Usuario no autenticado');
        // Handle case where user is not authenticated
      }
    } catch (e) {
      print('Error actualizando el número de tarjeta: $e');
      // Handle error
    }
  }

  bool validarCampo(String value) {
    if (value.isNotEmpty) {
      return false;
    }
    return true;
  }

  void tarjetaIntentar() async {
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

    if (tarjetaController.text != confirmartarjetaController.text) {
      print(
          tarjetaController.text != confirmartarjetaController.text + "bool");
      Navigator.pop(context);
      //mostrar mensaje de error
      showErrorMessage("No coinciden los numeros de tarjeta");
      return;
    }else if(validarCampo(tarjetaController.text)){
      Navigator.pop(context);
      showErrorMessage("Por favor introduzca un numero de tarjeta");
    }else if(validarCampo(confirmartarjetaController.text)){
      Navigator.pop(context);
      showErrorMessage("Por favor introduzca la confirmacion del numero de tarjeta");
    }else if(tarjetaController.text.length != 16 || confirmartarjetaController.text.length != 16){
      Navigator.pop(context);
      showErrorMessage("La longitud del numero de tarjeta es menor a 16");
    } else {
      try {
        await actualizarTarjeta(tarjetaController.text);

        //dejar de mostrar simbolo de carga
      } on FirebaseAuthException catch (e) {
        //dejar de mostrar simbolo de carga
        Navigator.pop(context);

        //mostrar mensaje de error
        showErrorMessage(e.code);
      }
    }
    //dejar de mostrar simbolo de carga
  }

  final tarjetaController = TextEditingController();
  final confirmartarjetaController = TextEditingController();
  Future<void> profile(BuildContext context) async {
    CircularProgressIndicator();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
  }

  final firebaseUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar numero de tarjeta'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 0,
            ),
            const Text(
              'Por favor, ingrese su nuevo número de tarjeta y confírmelo:',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 20,
                color: Color.fromARGB(255, 63, 59, 59),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                        maxLength: 16,
                        keyboardType: TextInputType.number,
                        controller: tarjetaController,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(16),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: false,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: "Numero de Tarjeta",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                        maxLength: 16,
                        keyboardType: TextInputType.number,
                        controller: confirmartarjetaController,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(16),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        obscureText: false,
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: "Confirmar numero de Tarjeta",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Guardar Cambios"),
                        content: Text(
                            '¿Seguro que deseas guardar los cambios realizados?'),
                        actions: [
                          TextButton(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: new Text("Continuar"),
                            onPressed: tarjetaIntentar,
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Guardar Numero de Tarjeta')),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Cancelar Cambios"),
                        content: Text(
                            '¿Seguro que deseas cancelar esto no guardara los cambios realizados?'),
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Cancelar')),
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
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
