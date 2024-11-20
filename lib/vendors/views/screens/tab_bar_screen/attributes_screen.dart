import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/product_provider.dart';

class AttributesScreen extends StatefulWidget {
  const AttributesScreen({super.key});

  @override
  State<AttributesScreen> createState() => _AttributesScreenState();
}

class _AttributesScreenState extends State<AttributesScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String? _selectedQualityGrade;
  String? _selectedPackagingType;
  int _deliveryDays = 1;

  final List<String> _qualityGrades = ['Grade A', 'Premium', 'Standard', 'Economy'];
  final List<String> _packagingTypes = ['Sack', 'Box', 'Crate', 'Bag'];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Attributes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Product Attributes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),

              // Quality Grade Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Quality Grade',
                  labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.grade, color: Colors.green),
                ),
                value: _selectedQualityGrade,
                items: _qualityGrades.map((String grade) {
                  return DropdownMenuItem<String>(
                    value: grade,
                    child: Text(grade),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedQualityGrade = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Product Quality Of Product'; // Validation message
                  }
                  return null; // No error
                },
              ),
              SizedBox(height: 16),

              // Packaging Type Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Packaging Type',
                  labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.all_inbox, color: Colors.blue),
                ),
                value: _selectedPackagingType,
                items: _packagingTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPackagingType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Product Packing Type'; // Validation message
                  }
                  return null; // No error
                },
              ),
              SizedBox(height: 20),

              // Delivery Days
              Row(
                children: [
                  Icon(Icons.delivery_dining, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    'Expected Delivery Time (days)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        if (_deliveryDays > 1) _deliveryDays--;
                      });
                    },
                  ),
                  Text(
                    '$_deliveryDays',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        _deliveryDays++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // Call the saveAttributes method from the ProductProvider
                  productProvider.saveAttributes(_selectedQualityGrade, _selectedPackagingType, _deliveryDays);

                  // Show a confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Attributes saved successfully!'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Optionally, you could clear the selections if desired
                  setState(() {
                    _selectedQualityGrade = null;
                    _selectedPackagingType = null;
                    _deliveryDays = 1; // Reset delivery days to default
                  });
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
