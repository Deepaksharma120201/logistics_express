import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/image_picker_service.dart';

class ProfilePicker extends StatefulWidget {
  final Function(File?) onImagePicked;
  final dynamic initialImage; // URL or null

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
    // Ensure initialImage is a valid URL before assigning
    if (widget.initialImage != null && widget.initialImage!.isNotEmpty) {
      _selectedImage = null; // Will be shown as a network image
    }
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
      color: Colors.grey,
    );

    if (_selectedImage != null) {
      // Show local file image
      content = ClipOval(
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: 140,
          height: 140,
        ),
      );
    } else if (widget.initialImage != null && widget.initialImage!.isNotEmpty) {
      // Show network image
      content = ClipOval(
        child: Image.network(
          widget.initialImage!,
          fit: BoxFit.cover,
          width: 140,
          height: 140,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, size: 80, color: Colors.red);
          },
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
