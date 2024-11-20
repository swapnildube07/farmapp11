import 'package:farmapp/vendors/views/screens/earning_screen.dart';
import 'package:farmapp/vendors/views/screens/edit_screen.dart';
import 'package:farmapp/vendors/views/screens/logout_screen.dart';
import 'package:farmapp/vendors/views/screens/upload_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({Key? key}) : super(key: key);

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _selectedIndex = 0;

  // List of screens corresponding to the bottom navigation bar
  List<Widget> _pages = [
    EarningScreen(),
    UploadScreen(),
    EditScreen(),
    LogoutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.brown[700], // Dark brown for selected icons
        unselectedItemColor: Colors.green[300], // Lighter green for unselected icons
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(CupertinoIcons.money_dollar, 0),
            label: 'Earning',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.upload, 1),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.edit, 2),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.logout, 3),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index) {
    // Create a transform to move the selected icon up
    double offset = _selectedIndex == index ? -10 : 0; // Move up by 10 pixels if selected

    return Transform.translate(
      offset: Offset(0, offset), // Apply vertical translation
      child: Icon(
        iconData,
        color: _selectedIndex == index
            ? Colors.brown[700] // Dark brown if selected
            : Colors.green[300], // Lighter green if unselected
        size: _selectedIndex == index ? 30 : 24, // Larger size if selected
      ),
    );
  }
}
