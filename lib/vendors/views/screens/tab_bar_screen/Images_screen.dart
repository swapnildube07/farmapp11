import 'dart:io';
import 'package:farmapp/vendors/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesScreen extends StatefulWidget {
  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  List<File> _imageFiles = [];
  List<String> _imageUrlList = [];

  Future<void> chooseImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  _addImageFile(pickedFile);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  _addImageFile(pickedFile);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addImageFile(XFile? pickedFile) {
    if (pickedFile != null) {
      if (_imageFiles.length < 3) {
        setState(() {
          _imageFiles.add(File(pickedFile.path));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You can only select up to 3 images.')),
        );
      }
    } else {
      print('No Image Picked');
    }
  }

  Future<void> uploadImages(ProductProvider productProvider) async {
    if (_imageFiles.isEmpty) {
      EasyLoading.showInfo('No images selected');
      return;
    }

    EasyLoading.show(status: 'Uploading images...');
    try {
      await Future.wait(_imageFiles.map((img) async {
        Reference ref = _storage.ref().child('Product Images').child(Uuid().v4().toString());
        await ref.putFile(img);
        String downloadUrl = await ref.getDownloadURL();
        _imageUrlList.add(downloadUrl);
      }));

      productProvider.getFormData(imageUrlList: _imageUrlList);
      EasyLoading.showSuccess('Images uploaded successfully!');
    } catch (e) {
      EasyLoading.showError('Upload failed: ${e.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void uploadProduct() {
    EasyLoading.showSuccess('Product uploaded successfully!'); // Placeholder for product upload logic
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Images'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to pick images from gallery or camera
            ElevatedButton(
              onPressed: chooseImage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Pick Images', style: TextStyle(color: Colors.white)),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),

            // Centered Upload Images button
            ElevatedButton(
              onPressed: () {
                final form = Form.of(context);
                if (form != null && form.validate()) {
                  uploadImages(productProvider);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all required fields.')),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_file, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Upload', style: TextStyle(color: Colors.white)),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            SizedBox(height: 20),

            // Grid to display selected images
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: _imageFiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_imageFiles[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _imageFiles.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
