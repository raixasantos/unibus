import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(File) onImageSelected;

  const ProfileImagePicker({required this.onImageSelected, Key? key})
      : super(key: key);

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      widget.onImageSelected(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_image != null)
          CircleAvatar(
            radius: 50, // ajuste conforme necessário
            backgroundImage: FileImage(_image!),
          ),
        ElevatedButton(
          onPressed: () => _getImage(ImageSource.gallery),
          child: Text('Selecionar da Galeria'),
        ),
        ElevatedButton(
          onPressed: () => _getImage(ImageSource.camera),
          child: Text('Tirar Foto'),
        ),
      ],
    );
  }
}
