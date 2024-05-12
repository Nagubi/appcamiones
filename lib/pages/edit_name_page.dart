import 'package:appcamiones/pages/inicio_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class EditNameScreen extends StatefulWidget {
  const EditNameScreen({Key? key});

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
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

  void successfulNameChange() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cambio de Nombre Exitoso"),
        content: Text('Su nombre fue actualizado con éxito.'),
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

  Future<void> actualizarNombre(String name) async {
    try {
      String? email = await getEmail();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Assuming you have a 'Perfil' collection where each document has a field 'Email'
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Perfil')
            .where('email', isEqualTo: email)
            .get();

        // If the document with the specified email exists, update its name
        if (querySnapshot.docs.isNotEmpty) {
          String documentId = querySnapshot.docs.first.id;
          await FirebaseFirestore.instance
              .collection('Perfil')
              .doc(documentId)
              .update({'Nombre': name});
          return successfulNameChange();
          // If the update is successful, print a success message
        } else {
          print('No se encontró ningún usuario con el correo electrónico especificado');
          // Handle case where user document doesn't exist
        }
      } else {
        print('Usuario no autenticado');
        // Handle case where user is not authenticated
      }
    } catch (e) {
      print('Error actualizando el nombre: $e');
      // Handle error
    }
  }

  bool validarCampo(String value) {
    if (value.isNotEmpty) {
      return false;
    }
    return true;
  }

  void nameChangeAttempt() async {
    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (nombreController.text != confirmarNombreController.text ||
        validarCampo(nombreController.text) ||
        validarCampo(confirmarNombreController.text)) {
      Navigator.pop(context);
      // Show error message
      showErrorMessage("Los nombres no coinciden");
      return;
    } else {
      try {
        await actualizarNombre(nombreController.text);
      } on FirebaseAuthException catch (e) {
        // Stop showing loading indicator
        Navigator.pop(context);
        // Show error message
        showErrorMessage(e.code);
      }
    }
  }

  final nombreController = TextEditingController();
  final confirmarNombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Nombre'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 63, 59, 59),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 0,),
            const Text(
              'Por favor, ingrese su nuevo nombre y confírmelo:',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 20,
                color: Color.fromARGB(255, 63, 59, 59),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[a-zA-Z ]"),
                          )
                        ],
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
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                controller: confirmarNombreController,
                inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r"[a-zA-Z ]"),
                          )
                        ],
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
                  hintText: "Confirmar Nombre",
                  hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Guardar Cambios"),
                      content: Text('¿Seguro que deseas guardar los cambios realizados?'),
                      actions: [
                        TextButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: new Text("Continuar"),
                          onPressed:
                            nameChangeAttempt,
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text('Guardar Nombre'),
              ),
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
            blurRadius: 10
          )
        ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}