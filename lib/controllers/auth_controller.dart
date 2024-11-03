import 'dart:ui';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  /// select image from gallaery or camera


  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if( _file!=null){
      return await _file.readAsBytes();
    }else{
      print('No Image Selected');
    }
  }

  // FUNCTION TO UPLOAD STORAGE

  _uploadVendorStoreimage(Uint8List? image)async{
    Reference ref =  _storage.ref().child('storeImage').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot  snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
  Future<String> VendorRegistrationForm(
      String businessName, // Fixed spelling
      String email,
      String fullName, // Fixed variable name consistency
      String phoneNumber, // Fixed variable name consistency
      String countryValue,
      String stateValue,
      String cityValue,
      Uint8List? image,
      )async{
    String res = 'Something Went Wrong';

    try{

       String downloadurl =    await _uploadVendorStoreimage(image);
      await _firestore.collection('Vendors').doc(_auth.currentUser!.uid).set({
        'bussinessName': businessName,
        'EmailAddress': email,
        'Name':fullName,
        'countryValue': countryValue,
        'StateValue': stateValue,
        'cityValue': cityValue,
        'image': downloadurl,
        'MobileNumber':phoneNumber,
        'farmerID': _auth.currentUser!.uid,
        'approved':false ,
      }  );

      res = 'success';
    }catch(e) {
      res = e.toString();
    }
    return res;
  }


  // FUNCTION  TO LOGIN THE CREATED USER

  Future<String> loginUser( String email , String Password)async{
    String res = 'some error Occurred';
    try{
      await  _auth.signInWithEmailAndPassword(email: email, password: Password);
      res = 'Success';
    }catch(e){
      res = e.toString();
    }
    return res;
  }
}