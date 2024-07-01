import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  File? _image;
  final picker = ImagePicker();
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload to Firestore'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  getImage();
                },
                child: const Text('Pick an image'),
              ),
              SizedBox(
                height: 200,
                child: _image == null
                    ? const Center(child: Text('No image selected.'))
                    : Image.file(_image!),
              ),
              ElevatedButton(
                  child: const Text('Upload to Firestore'),
                  onPressed: () {
                    uploadImage();
                  }),
              Text(_message),
            ],
          )),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _message = 'No image selected.';
      }
    });
  }

  Future uploadImage() async {
    if (_image == null) {
      String filename = basename(_image!.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(filename);
      setState(() {
        _message = 'Uploading file. Please wait...';
      });
      await ref.putFile(_image!).then((TaskSnapshot taskSnapshot) {
        setState(() {
          _message = 'File uploaded!';
        });
      }).catchError((e) {
        setState(() {
          _message = 'Error uploading file: $e';
        });
      });
    }

    final fileName = basename(_image!.path);
    final destination = 'files/$fileName';

    final ref = FirebaseStorage.instance.ref().child(destination);
    final uploadTask = ref.putFile(_image!);

    await uploadTask.whenComplete(() {
      setState(() {
        _message = 'File uploaded!';
      });
    });
  }
}
