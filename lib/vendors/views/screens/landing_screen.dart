import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/models/vendor_models.dart';
import 'package:farmapp/vendors/views/auth/vendor_registration_screen.dart';
import 'package:farmapp/vendors/views/screens/main_vendor_screen.dart';
import 'package:farmapp/vendors/views/screens/vendorMapScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final CollectionReference _vendorsStream =
        FirebaseFirestore.instance.collection('Vendors');
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(!snapshot.data!.exists){
            return VendorRegistrationScreen();
          }



          VendorUserModel vendorUserModel = VendorUserModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>);

          if(vendorUserModel.approved== true){
            return MainVendorScreen();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      vendorUserModel.image,
                      width: 90,
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  vendorUserModel.bussinessName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Your Application ,Has Been Send To Shop Admin will get back to you Soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(onPressed: () async
                {
                  await _auth.signOut();
                }, child: Text("Sign Out"))
              ],
            ),
          );
        },
      ),
    );
  }
}
