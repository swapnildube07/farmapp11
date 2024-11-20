import 'package:farmapp/vendors/provider/product_provider.dart';
import 'package:farmapp/vendors/views/auth/vendor_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with specific options for Android
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAF5KRZPnTUjPKjf_3M27BbJYw3g-M6I6w',
        appId: '1:810821731815:android:e4d328337a97a6a844e942',
        messagingSenderId: '810821731815',
        projectId: 'fresh-1bb19',
        storageBucket: 'fresh-1bb19.appspot.com',
      ),
    );
  } else {
    // General initialization for other platforms (iOS/web)
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ProductProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
