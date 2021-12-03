import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'main.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  File? _imageFile;
  File? compressFile;
  final picker = ImagePicker();
  int sizeOfOriginalImage = 0;
  int sizeOfCompressedFile = 0;

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
        actions: [
          IconButton(
              onPressed: () {
                pickImage().then((value) async {
                  var size = await _imageFile!.length();
                  setState(() {
                    sizeOfOriginalImage = size;
                  });
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                const Opacity(opacity: 0, child: Divider()),
                TextButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(6.0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black54)),
                  child: const Text(
                    'Compress',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final dir = await path_provider.getTemporaryDirectory();
                    final tp = dir.absolute.path + "/temp.jpg";
                    var compressedFile =
                        await testCompressAndGetFile(_imageFile!, tp);
                    int tempSize = await compressedFile.length();
                    setState(() {
                      compressFile = compressedFile;
                      sizeOfCompressedFile = tempSize;
                    });
                  },
                ),
                const Opacity(opacity: 0, child: Divider()),
                (_imageFile != null
                    ? (Text(
                        'Size of original image : $sizeOfOriginalImage bytes'))
                    : const Text('No image selected')),
                    const Opacity(opacity: 0, child: Divider()),
                SizedBox(
                  height: displayHeight(context) * 0.3,
                  width: displayWidth(context) * 0.5,
                  child: (compressFile != null)
                      ? Image.file(
                          compressFile!,
                          fit: BoxFit.fill,
                        )
                      : null,
                ),
                const Opacity(opacity: 0, child: Divider()),
                (compressFile != null
                    ? (Text(
                        'Size of Compressed image : $sizeOfCompressedFile bytes'))
                    : const Text('No image selected')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<File> testCompressAndGetFile(File file, String targetPath) async {
  print('reached');
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 15,
    //rotate: 90,
  );
  //print(result!.lengthSync());

  return result!;
}
