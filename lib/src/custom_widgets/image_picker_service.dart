import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(BuildContext context) async {
  final imagePicker = ImagePicker();
  File? selectedFile;

  await showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(FontAwesomeIcons.camera),
              title: const Text('Take Picture'),
              onTap: () async {
                final pickedImage = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 600,
                );
                if (pickedImage != null) {
                  selectedFile = File(pickedImage.path);
                }
                if (context.mounted) {
                  Navigator.of(ctx).pop();
                }
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.images),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                final pickedImage = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 600,
                );
                if (pickedImage != null) {
                  selectedFile = File(pickedImage.path);
                }
                if (context.mounted) {
                  Navigator.of(ctx).pop();
                }
              },
            ),
          ],
        ),
      );
    },
  );

  return selectedFile;
}
