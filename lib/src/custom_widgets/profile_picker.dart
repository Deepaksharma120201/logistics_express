import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/image_picker_service.dart';

class ProfilePicker extends StatefulWidget {
  final Function(File?) onImagePicked;
  final File? initialImage;

  const ProfilePicker({
    super.key,
    required this.onImagePicked,
    this.initialImage,
  });

  @override
  State<ProfilePicker> createState() => _ProfilePickerState();
}

class _ProfilePickerState extends State<ProfilePicker> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  Future<void> _pickImage() async {
    final file = await pickImage(context);
    if (file != null) {
      setState(() {
        _selectedImage = file;
      });
      widget.onImagePicked(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Icon(
      FontAwesomeIcons.user,
      size: 80,
    );

    if (_selectedImage != null) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ClipOval(
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1.5, color: Colors.grey.shade300),
          ),
          child: content,
        ),
        Positioned(
          bottom: -4,
          right: 5,
          child: IconButton(
            onPressed: _pickImage,
            icon: Icon(
              FontAwesomeIcons.camera,
              color: Theme.of(context).shadowColor,
            ),
            tooltip: 'Edit Image',
          ),
        ),
      ],
    );
  }
}
