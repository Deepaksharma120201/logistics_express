// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class TakeImage extends StatefulWidget {
//   const TakeImage({
//     super.key,
//     required this.text,
//     this.toggle,
//   });
//
//   final String text;
//   final void Function()? toggle;
//   @override
//   State<TakeImage> createState() => _TakeImageState();
// }
//
// class _TakeImageState extends State<TakeImage> {
//   File? _selectedImage;
//
//   void _takePicture() async {
//     final imagePicker = ImagePicker();
//     final pickedImage =
//         await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
//
//     if (pickedImage == null) {
//       return;
//     }
//     setState(() {
//       _selectedImage = File(pickedImage.path);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget content = ElevatedButton.icon(
//       icon: Icon(Icons.image_rounded),
//       onPressed: _takePicture,
//       label: Text(widget.text),
//     );
//
//     if (_selectedImage != null) {
//       content = GestureDetector(
//         onTap: _takePicture,
//         child: Image.file(
//           _selectedImage!,
//           fit: BoxFit.cover,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       );
//     }
//
//     return Container(
//       width: double.infinity,
//       alignment: Alignment.center,
//       height: 220,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           width: 1,
//           color: Colors.black,
//         ),
//       ),
//       child: content,
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakeImage extends StatefulWidget {
  const TakeImage({
    super.key,
    required this.text,
    this.toggle,
  });

  final String text;
  final void Function()? toggle;
  @override
  State<TakeImage> createState() => _TakeImageState();
}

class _TakeImageState extends State<TakeImage> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();

    // Show bottom sheet modal to choose image source
    await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text('Take Picture'),
                onTap: () async {
                  Navigator.of(ctx).pop(); // Close the modal

                  // Pick image from camera
                  final pickedImage = await imagePicker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 600,
                  );

                  if (pickedImage != null) {
                    setState(() {
                      _selectedImage = File(pickedImage.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.of(ctx).pop(); // Close the modal

                  // Pick image from gallery
                  final pickedImage = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 600,
                  );

                  if (pickedImage != null) {
                    setState(() {
                      _selectedImage = File(pickedImage.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ElevatedButton.icon(
      icon: Icon(Icons.image_rounded),
      onPressed: _takePicture,
      label: Text(widget.text),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
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
