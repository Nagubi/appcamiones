import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  
  //Inicio de Sesion Google
  signInWithGoogle() async {
    //GoogleSignIn().signOut();
    //iniciar el proceso de inicio interactivo
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtener los detalles de autorizacion de la peticion
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //crear nueva credencial para el usuario
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finalmente vamos a iniciar sesion
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}