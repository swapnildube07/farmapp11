import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/vendors/provider/product_provider.dart';
import 'package:farmapp/vendors/views/screens/tab_bar_screen/General_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:farmapp/vendors/views/screens/tab_bar_screen/images_screen.dart';
import 'package:farmapp/vendors/views/screens/tab_bar_screen/attributes_screen.dart';
import 'package:farmapp/vendors/views/screens/tab_bar_screen/shipping_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider = Provider.of<ProductProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(child: Text('General')),
              Tab(child: Text('Shipping')),
              Tab(child: Text('Attributes')),
              Tab(child: Text('Images')),
            ],
          ),
          title: Text('Upload Product'),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            children: [
              GeneralScreen(),
              ShippingScreen(),
              AttributesScreen(),
              ImagesScreen(),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () async {
              DocumentSnapshot userDoc =await _firestore.collection('vendors').doc(_auth.currentUser!.uid).get();
              final productId = Uuid().v4();

              // Validate the form before proceeding
              if (_formKey.currentState!.validate()) {

                // Show EasyLoading loader
                EasyLoading.show(status: 'Uploading...');

                await _firestore.collection('Products').doc(productId).set({
                  'productId': productId,
                  'productName': _productProvider.productData['ProductName'], // Ensure this data is populated
                  'productPrice': _productProvider.productData['ProductPrice'], // Ensure this data is populated
                  'productQuantity': _productProvider.productData['ProductQuantity'], // Ensure this data is populated
                  'category': _productProvider.productData['Category'], // Ensure this data is populated
                  'description': _productProvider.productData['Description'],
                  'ChargeShipping': _productProvider.productData['ChargeShipping'], // Include ChargeShipping
                  'ShippingCharge': _productProvider.productData['ShippingCharge'], // Include ShippingCharge
                  'ImageUrlList': _productProvider.productData['ImageUrlList'], // Include ImageUrlList
                  'QualityGrades': _productProvider.productData['QualityGrades'], // Include QualityGrades
                  'PackagingType': _productProvider.productData['PackagingType'], // Include PackagingType
                  'DeliveryDays': _productProvider.productData['DeliveryDays'], // Include DeliveryDays
                  'farmerID':_auth.currentUser!.uid,
                  //'bussinessName':(userDoc.data() as Map<String , dynamic>)['bussinessName'],
                  'timestamp': FieldValue.serverTimestamp(),
                }).whenComplete(() {
                  EasyLoading.dismiss(); // Dismiss EasyLoading on completion
                  _productProvider.ClearData();

                  // Show a confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Product Uploaded Successfully!')),
                  );
                });

                // Optionally, reset the form after successful upload
                _formKey.currentState!.reset();
              } else {
                print('Form Not Validated');
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Upload Product',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
