import 'package:appcamiones/pages/inicio_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditPhoneScreen extends StatefulWidget {
  const EditPhoneScreen({super.key});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
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
        title: Text("Cambio de Teléfono Exitoso"),
        content: Text('Su número de teléfono fue actualizado con éxito.'),
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

  Future actualizarTelefono(String number) async {
    try {
      String? email = await getEmail();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Assuming you have a 'Perfil' collection where each document has a field 'Email'
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Perfil')
            .where('email', isEqualTo: email)
            .get();

        // If the document with the specified email exists, update its phone number
        if (querySnapshot.docs.isNotEmpty) {
          String documentId = querySnapshot.docs.first.id;
          await FirebaseFirestore.instance
              .collection('Perfil')
              .doc(documentId)
              .update({'Telefono': number});
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
      print('Error actualizando el número de teléfono: $e');
      // Handle error
    }
  }

  bool validarCampo(String value) {
    if (value.isNotEmpty) {
      return false;
    }
    return true;
  }

  void telefonoIntentar() async {
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

    if (telefonoController.text != confirmartelefonoController.text) {
      print(
          telefonoController.text != confirmartelefonoController.text + "bool");
      Navigator.pop(context);
      //mostrar mensaje de error
      showErrorMessage("No coinciden los telefonos");
      return;
    }else if(validarCampo(telefonoController.text)){
      Navigator.pop(context);
      showErrorMessage("Por favor introduzca un numero de telefono");
    }else if(validarCampo(confirmartelefonoController.text)){
      Navigator.pop(context);
      showErrorMessage("Por favor introduzca la confirmacion del numero de telefono");
    }else if(telefonoController.text.length != 10 || confirmartelefonoController.text.length != 10){
      Navigator.pop(context);
      showErrorMessage("La longitud del numero de telefono es menor a 10");
    } else {
      try {
        await actualizarTelefono(telefonoController.text);

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

  final telefonoController = TextEditingController();
  final confirmartelefonoController = TextEditingController();
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
        title: Text('Cambiar numero de telefono'),
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
              'Por favor, ingrese su nuevo número de teléfono y confírmelo:',
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
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: telefonoController,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
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
                            hintText: "Telefono",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: confirmartelefonoController,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
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
                            hintText: "Confirmar Telefono",
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
                            onPressed: telefonoIntentar,
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Guardar Numero de Telefono')),
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
