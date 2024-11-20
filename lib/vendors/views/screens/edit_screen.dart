import 'package:farmapp/vendors/views/screens/tab_bar_screen/General_screen.dart';
import 'package:farmapp/vendors/views/screens/tab_bar_screen/Images_screen.dart';
import 'package:farmapp/vendors/views/screens/tab_bar_screen/attributes_screen.dart';
import 'package:farmapp/vendors/views/screens/tab_bar_screen/shipping_screen.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:Text('Edit')
      ),
    );
  }
}
