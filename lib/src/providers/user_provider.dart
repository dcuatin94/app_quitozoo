// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  User? get user => _user;
  set user(User? newUser) {
    _user = newUser;
    _isLoggedIn = newUser != null;
    notifyListeners();
  }

  //Metodo para iniciar sesion
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      user = userCredential.user;
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, '/');
      } //Actualiza el estado del usuario
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Sus credenciales son incorrectas',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        elevation: 4.0,
      ));
      user = null;
    }
    notifyListeners();
  }

  //Metodo para cerrar sesion
  Future<void> signOut() async {
    await _auth.signOut();
    user = null; //Actualiza el estado del usuario
    isLoggedIn = false;
    notifyListeners();
  }

  //Metodo para registrar un nuevo usuario
  Future<void> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user; //Actualiza el estado del usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Cuenta registrada exitosamente. Rediriginedo al inicio de sesión...',
              style: TextStyle(color: Colors.white)),
          duration: Duration(seconds: 2),
          backgroundColor: const Color.fromARGB(255, 119, 66, 23),
          elevation: 4.0,
        ),
      );
    } catch (e) {
      user = null;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error al registrar el usuario: $e',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        elevation: 4.0,
      ));
    }
    notifyListeners();
  }

  //Metodo para restablecer la contrasena
  Future<void> resetPassword(String email, context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error al iniciar sesion: $e',
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        elevation: 4.0,
      ));
    }
    notifyListeners();
  }

  //Metodo para comprobar si el usuario esta autenticado
  void checkAuth() {
    _auth.authStateChanges().listen((User? checkUser) {
      user = checkUser;
    });
    notifyListeners();
  }
}
