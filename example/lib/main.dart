import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_cropper/image_picker_cropper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              ImagePickerCropperManager pickerCropperManager =
                  ImagePickerCropperManager();
              var pickedImage = await pickerCropperManager.pickAndCropImage();
              if (pickedImage != null) {
                setState(() {
                  _pickedImage = File(pickedImage.path);
                });
              }
            },
            child: const Text('Pick Image'),
          ),
          const SizedBox(height: 20),
          if (_pickedImage != null)
            Expanded(
              child: Image.file(
                _pickedImage!,
                fit: BoxFit.cover, // This makes the image take full width
              ),
            ),
        ],
      ),
    );
  }
}
