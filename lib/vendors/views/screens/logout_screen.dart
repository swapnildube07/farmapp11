import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Move _auth here

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      // Optionally navigate to a different screen after sign out
      Navigator.pushReplacementNamed(context, '/login'); // Replace with your login screen route
    } catch (e) {
      // Handle error here, maybe show a dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: _signOut, // Call _signOut method
          child: Text(
            'Sign Out',
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
