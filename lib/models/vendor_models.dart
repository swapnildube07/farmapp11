import 'dart:typed_data'; // Import if you want to handle images as bytes

class VendorUserModel {
  final String emailAddress;   // Vendor's email address
  final String mobileNumber;   // Vendor's mobile number
  final String name;           // Vendor's name
  final String stateValue;     // State of the vendor
  final bool approved;         // Approval status
  final String businessName;   // Name of the vendor's business
  final String cityValue;      // City of the vendor
  final String countryValue;   // Country of the vendor
  final String farmerID;       // Unique identifier for the farmer

  // Constructor
  VendorUserModel({
    required this.emailAddress,
    required this.mobileNumber,
    required this.name,
    required this.stateValue,
    required this.approved,
    required this.businessName,
    required this.cityValue,
    required this.countryValue,
    required this.farmerID,
  });

  // Factory method to create a VendorUserModel from a map
  factory VendorUserModel.fromMap(Map<String, dynamic> map) {
    return VendorUserModel(
      emailAddress: map['emailAddress'] as String,
      mobileNumber: map['mobileNumber'] as String,
      name: map['name'] as String,
      stateValue: map['stateValue'] as String,
      approved: map['approved'] as bool,
      businessName: map['businessName'] as String,
      cityValue: map['cityValue'] as String,
      countryValue: map['countryValue'] as String,
      farmerID: map['farmerID'] as String,
    );
  }

  // Factory method to create a VendorUserModel from JSON
  factory VendorUserModel.fromJson(Map<String, Object?> json) {
    return VendorUserModel(
      emailAddress: json['emailAddress']! as String,
      mobileNumber: json['mobileNumber']! as String,
      name: json['name']! as String,
      stateValue: json['stateValue']! as String,
      approved: json['approved']! as bool,
      businessName: json['businessName']! as String,
      cityValue: json['cityValue']! as String,
      countryValue: json['countryValue']! as String,
      farmerID: json['farmerID']! as String,
    );
  }

  // Method to convert a VendorUserModel to a map (for saving to Firestore or API)
  Map<String, Object?> toMap() {
    return {
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
      'name': name,
      'stateValue': stateValue,
      'approved': approved,
      'businessName': businessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'farmerID': farmerID,
    };
  }

  // Method to convert a VendorUserModel to JSON (for sending to an API)
  Map<String, Object?> toJson() {
    return {
      'emailAddress': emailAddress,
      'mobileNumber': mobileNumber,
      'name': name,
      'stateValue': stateValue,
      'approved': approved,
      'businessName': businessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'farmerID': farmerID,
    };
  }
}
