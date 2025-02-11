import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'image_picker_service.dart';

class TakeImage extends StatefulWidget {
  const TakeImage({
    super.key,
    required this.text,
    required this.onImageSelected,
  });

  final String text;
  final void Function(File) onImageSelected;

  @override
  State<TakeImage> createState() => _TakeImageState();
}

class _TakeImageState extends State<TakeImage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final file = await pickImage(context);
    if (file != null) {
      setState(() {
        _selectedImage = file;
      });
      widget.onImageSelected(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
      icon: const Icon(FontAwesomeIcons.image),
      onPressed: _pickImage,
      label: Text(widget.text),
    );

    if (_selectedImage != null) {
      content = Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.pencil, color: Colors.white),
            onPressed: _pickImage,
            tooltip: 'Edit Image',
          ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
      ),
      child: content,
    );
  }
}
