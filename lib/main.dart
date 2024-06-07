import 'package:flutter/material.dart';
import 'package:smart_pharmacy/Core/Service/auth_service.dart';
import 'package:smart_pharmacy/Views/Screens/homescreen.dart';
import 'package:smart_pharmacy/Views/Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  final isLoggedIn = await AuthService.isUserLoggedIn();

  runApp( MyApp(isLoggedIn: isLoggedIn,));
}

 class MyApp extends StatelessWidget {
  final bool isLoggedIn ;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Pharmacy',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn? HomeScreen():  SplashScreen(),
    );
  }
}