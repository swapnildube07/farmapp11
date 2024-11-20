import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic> productData = {};

  List<String> qualityGrades = [];
  String? packagingType;
  int deliveryDays = 1;

  void getFormData({
    String? productName,
    double? productPrice,
    int? productQuantity,
    String? category,
    String? description,
    bool? chargeShipping,
    double? shippingCharge,
    List<String>? imageUrlList,
  }) {
    if (productName != null) {
      productData['ProductName'] = productName;
    }
    if (productPrice != null) {
      productData['ProductPrice'] = productPrice;
    }
    if (productQuantity != null) {
      productData['ProductQuantity'] = productQuantity;
    }
    if (category != null) {
      productData['Category'] = category;
    }
    if (description != null) {
      productData['Description'] = description;
    }
    if (chargeShipping != null) {
      productData['ChargeShipping'] = chargeShipping;
    }
    if (shippingCharge != null) {
      productData['ShippingCharge'] = shippingCharge;
    }
    if (imageUrlList != null) {
      productData['ImageUrlList'] = imageUrlList;
    }

    notifyListeners(); // Notify listeners about data changes
  }

  void saveAttributes(String? selectedQualityGrade, String? selectedPackagingType, int deliveryDays) {
    qualityGrades = selectedQualityGrade != null ? [selectedQualityGrade] : [];
    packagingType = selectedPackagingType;
    this.deliveryDays = deliveryDays;

    productData['QualityGrades'] = qualityGrades;
    productData['PackagingType'] = packagingType;
    productData['DeliveryDays'] = deliveryDays;

    notifyListeners(); // Notify listeners about data changes
  }

  Future<void> uploadProductData() async {
    // Implement the logic to upload product data to Firestore or your backend
    // Example:
    try {
      // Assuming you have a Firestore instance
      // await FirebaseFirestore.instance.collection('Products').add(productData);
      print('Product Data: $productData');
    } catch (error) {
      print('Error uploading product data: $error');
    }
  }
  ClearData(){
    productData.clear();
    notifyListeners();
  }
}
