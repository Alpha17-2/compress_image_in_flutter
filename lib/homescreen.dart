import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  File? _imageFile;
  final picker = ImagePicker();
  int sizeOfOriginalImage = 0;

  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (mounted) {
        setState(() {
          _imageFile = File(pickedFile!.path);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Compress image",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  backgroundColor: MaterialStateProperty.all(Colors.black54)),
              child: const Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                pickImage().then((value) async {
                  sizeOfOriginalImage = await _imageFile!.length();
                  print(sizeOfOriginalImage);
                });
              },
            ),
            SizedBox(
              height: displayHeight(context) * 0.3,
              width: displayWidth(context) * 0.5,
              child: (_imageFile != null)
                  ? Image.file(
                      _imageFile!,
                      fit: BoxFit.fill,
                    )
                  : null,
            ),
            const Opacity(opacity: 0,child: Divider()),
            (_imageFile != null
                ? (Text('Size of original image : $sizeOfOriginalImage bytes'))
                : const Text('No image selected')),
          ],
        ),
      ),
    );
  }
}
