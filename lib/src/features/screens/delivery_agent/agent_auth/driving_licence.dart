import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logistics_express/src/custom_widgets/firebase_exceptions.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/take_image.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/vehicle_rc.dart';
import 'package:logistics_express/src/services/cloudinary/cloudinary_service.dart';

class DrivingLicence extends StatefulWidget {
  const DrivingLicence({super.key});

  @override
  State<DrivingLicence> createState() => _DrivingLicenceState();
}

class _DrivingLicenceState extends State<DrivingLicence> {
  File? _frontImage;
  File? _backImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          title: const Text('Driving Licence'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TakeImage(
                text: 'Upload Front-side',
                onImageSelected: (File image) {
                  setState(() {
                    _frontImage = image;
                  });
                },
              ),
              const SizedBox(height: 14),
              TakeImage(
                text: 'Upload Back-side',
                onImageSelected: (File image) {
                  setState(() {
                    _backImage = image;
                  });
                },
              ),
              const SizedBox(height: 25),
              FormTextField(
                label: 'Driving Licence No.',
                hintText: 'Enter here',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              const Text('Eg: KA12345677899029'),
              const SizedBox(height: 5),
              const Text('Special characters are not allowed'),
              const SizedBox(height: 25),
              Center(
                child: SubmitImage(
                  frontImage: _frontImage,
                  backImage: _backImage,
                  route: (ctx) => const VehicleRc(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubmitImage extends StatelessWidget {
  const SubmitImage({
    super.key,
    required File? frontImage,
    required File? backImage,
    required this.route,
  })  : _frontImage = frontImage,
        _backImage = backImage;

  final File? _frontImage;
  final File? _backImage;
  final Widget Function(BuildContext) route;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_frontImage != null && _backImage != null) {
          try {
            bool response1 = await uploadToCloudinary(context, _frontImage!);
            bool response2 = await uploadToCloudinary(context, _backImage!);

            if (response1 && response2 && context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: route,
                ),
              );
            } else {
              if (context.mounted) {
                showErrorSnackBar(
                  context,
                  "Failed to upload images. Please try again.",
                );
              }
            }
          } catch (e) {
            if (context.mounted) {
              showErrorSnackBar(
                context,
                "An error occurred. Please try again.",
              );
            }
          }
        } else {
          showErrorSnackBar(
            context,
            "Please every required field!",
          );
        }
      },
      child: const Text('Submit'),
    );
  }
}
