import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:unibus/components/UserProvider.dart';
import 'package:unibus/models/Usuario.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(File) onImageSelected;

  const ProfileImagePicker({required this.onImageSelected, Key? key})
      : super(key: key);

  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        userProvider.user.imageUrl = File(pickedFile!.path);
      });

      widget.onImageSelected(userProvider.user.imageUrl!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            Usuario user = userProvider.user;
            if (user.imageUrl != null){
              return CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(user.imageUrl!),
              );
            }
            return Container();
          },
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
