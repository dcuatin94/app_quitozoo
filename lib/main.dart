import 'package:app_zoologico/src/authentication/reset_password.dart';
import 'package:app_zoologico/src/pages/animalInfoPage.dart';
import 'package:app_zoologico/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:app_zoologico/src/authentication/register.dart';
import 'package:app_zoologico/src/pages/bienvenidos.dart';
import 'package:app_zoologico/src/pages/menu.dart';
import 'package:app_zoologico/src/pages/page_not_found.dart';
import 'package:app_zoologico/src/authentication/login.dart';
// Asegúrate de que la ruta es correcta. Si tu archivo home.dart está en lib/src/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _routes = {
    '/': (context) => const BienvenidoScreen(),
    '/menu': (context) => const Menu(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/reset-password': (context) => const ResetPasswordPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoologico App',
      debugShowCheckedModeBanner: false, // Elimina la bandera de depuración
      initialRoute: '/login',
      routes: _routes,
      onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) =>
              const PageNotFound()), // Asegúrate de que HomeScreen está bien definido e importado
    );
  }
}
