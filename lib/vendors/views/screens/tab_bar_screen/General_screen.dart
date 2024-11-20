import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/vendors/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];
  String? _selectedCategory;
  String? _productName;
  double? _productPrice;
  int? _productQuantity;
  String? _description;

  Future<void> _getCategories() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Categories').get();
      setState(() {
        _categoryList.addAll(querySnapshot.docs.map((doc) => doc['categoryName'] as String));
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white, // Changed to an alternative color
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    label: 'Product Name',
                    hint: 'Enter Product Name',
                    icon: Icons.local_offer,
                    onChanged: (value) {
                      _productName = value;
                      productProvider.getFormData(
                        productName: _productName,
                        productPrice: _productPrice,
                        productQuantity: _productQuantity,
                        category: _selectedCategory,
                        description: _description,
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildTextField(
                    label: 'Price',
                    hint: 'Enter Price',
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _productPrice = double.tryParse(value);
                      productProvider.getFormData(
                        productName: _productName,
                        productPrice: _productPrice,
                        productQuantity: _productQuantity,
                        category: _selectedCategory,
                        description: _description,
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildTextField(
                    label: 'Quantity',
                    hint: 'Enter Quantity',
                    icon: Icons.format_list_numbered,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _productQuantity = int.tryParse(value);
                      productProvider.getFormData(
                        productName: _productName,
                        productPrice: _productPrice,
                        productQuantity: _productQuantity,
                        category: _selectedCategory,
                        description: _description,
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildDropdownField(),
                  SizedBox(height: 16.0),
                  _buildTextAreaField(),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        labelStyle: TextStyle(color: Colors.green), // Changed label color
        prefixIcon: Icon(icon, color: Colors.green), // Changed icon color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green), // Changed border color
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.all(16),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label'; // Validation message
        }
        return null; // No error
      },
    );
  }

  Widget _buildTextAreaField() {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Enter Product Description',
        labelText: 'Product Description',
        labelStyle: TextStyle(color: Colors.green), // Changed label color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green), // Changed border color
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.all(16),
      ),
      onChanged: (value) {
        _description = value;
        Provider.of<ProductProvider>(context, listen: false).getFormData(
          productName: _productName,
          productPrice: _productPrice,
          productQuantity: _productQuantity,
          category: _selectedCategory,
          description: _description,
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Product Description'; // Validation message
        }
        return null; // No error
      },
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      hint: Text('Select Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      items: _categoryList.map<DropdownMenuItem<String>>((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
        Provider.of<ProductProvider>(context, listen: false).getFormData(
          productName: _productName,
          productPrice: _productPrice,
          productQuantity: _productQuantity,
          category: _selectedCategory,
          description: _description,
        );
      },
      decoration: InputDecoration(
        labelText: 'Category',
        labelStyle: TextStyle(color: Colors.green), // Changed label color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green), // Changed border color
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
