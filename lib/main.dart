 // Ensure this path is correct
import 'package:farmapp/vendors/views/auth/vendor_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart'; // Import Get package
import 'dart:io';

 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   Platform.isAndroid?
   await Firebase.initializeApp(
     options: const FirebaseOptions(
         apiKey: 'AIzaSyAF5KRZPnTUjPKjf_3M27BbJYw3g-M6I6w',
         appId: '1:810821731815:android:e4d328337a97a6a844e942',
         messagingSenderId: '810821731815',
         projectId: 'fresh-1bb19',
         storageBucket: 'fresh-1bb19.appspot.com'),
   )

       : await Firebase.initializeApp();

   runApp(const MyApp());
 }

 class MyApp extends StatelessWidget {
   const MyApp({super.key});

   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
     return GetMaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Flutter Demo',
       theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
         useMaterial3: true,
       ),
       home: LoginScreen(),
       builder: EasyLoading.init(),
     );
   }
 }