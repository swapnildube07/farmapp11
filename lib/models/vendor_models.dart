import 'dart:typed_data'; // Import if you want to handle images as bytes

class VendorUserModel {
  final String EmailAddress;   // Vendor's email address
  final String MobileNumber;   // Vendor's mobile number
  final String name;           // Vendor's name
  final String StateValue;     // State of the vendor
  final bool approved;         // Approval status
  final String bussinessName;  // Name of the vendor's business
  final String cityValue;      // City of the vendor
  final String countryValue;   // Country of the vendor
  final String farmerID;// Unique identifier for the farmer
  final String image;


  // Constructor
  VendorUserModel({
    required this.EmailAddress,
    required this.MobileNumber,
    required this.name,
    required this.StateValue,
    required this.approved,
    required this.bussinessName,
    required this.cityValue,
    required this.countryValue,
    required this.farmerID,
    required this.image

  });

  // Factory method to create an instance from JSON
  factory VendorUserModel.fromJson(Map<String, Object?> json) {
    return VendorUserModel(
      EmailAddress: json['EmailAddress'] as String? ?? '', // Use default empty string if null
      MobileNumber: json['MobileNumber'] as String? ?? '',
      name: json['name'] as String? ?? '',
      StateValue: json['StateValue'] as String? ?? '',
      approved: json['approved'] as bool? ?? false, // Use false if null
      bussinessName: json['bussinessName'] as String? ?? '',
      cityValue: json['cityValue'] as String? ?? '',
      countryValue: json['countryValue'] as String? ?? '',
      farmerID: json['farmerID'] as String? ?? '',
      image: json['image'] as String? ?? ' '

    );
  }

  // Method to convert a VendorUserModel to JSON (for sending to an API)
  Map<String, Object?> toJson() {
    return {
      'emailAddress': EmailAddress,
      'mobileNumber': MobileNumber,
      'name': name,
      'stateValue': StateValue,
      'approved': approved,
      'businessName': bussinessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'farmerID': farmerID,
      'image': image
    };
  }
}
