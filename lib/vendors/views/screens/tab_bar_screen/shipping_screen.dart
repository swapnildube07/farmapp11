import 'package:farmapp/vendors/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _chargeShipping = false;
  double? _shippingCharge;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        shadowColor: Colors.green.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping Options',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              // Shipping Charge Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_shipping, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Charge Shipping?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: _chargeShipping,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        _chargeShipping = value;
                        _productProvider.getFormData(chargeShipping: _chargeShipping);
                        if (!_chargeShipping) _shippingCharge = null; // Reset charge if not required
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Conditionally display the Shipping Charge field
              if (_chargeShipping) _buildShippingChargeField(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build the shipping charge input field
  Widget _buildShippingChargeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Shipping Charge',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Amount',
            labelStyle: TextStyle(color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.all(16),
            hintText: 'e.g. 5.99',
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              _shippingCharge = double.tryParse(value);
              Provider.of<ProductProvider>(context, listen: false).getFormData(shippingCharge: _shippingCharge);
            });
          },
          // Removed the validator
        ),
      ],
    );
  }
}
