import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/image_picker.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/vehicle_rc.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import 'package:logistics_express/src/utils/validators.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';
import 'package:logistics_express/src/services/cloudinary/cloudinary_service.dart';

class DrivingLicence extends ConsumerStatefulWidget {
  const DrivingLicence({super.key});

  @override
  ConsumerState<DrivingLicence> createState() => _DrivingLicenceState();
}

class _DrivingLicenceState extends ConsumerState<DrivingLicence> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  File? _frontImage;
  File? _backImage;

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);

    void submitForm() async {
      try {
        if (_frontImage != null && _backImage != null) {
          setState(() => _isLoading = true);
          String? response1 = await uploadToCloudinary(context, _frontImage!);
          if (!context.mounted) return;
          String? response2 = await uploadToCloudinary(context, _backImage!);

          if (response1 != null && response2 != null) {
            User? user = FirebaseAuth.instance.currentUser;
            await FirebaseFirestore.instance
                .collection('agents')
                .doc(user!.uid)
                .update({
              'DLFrontImageUrl': response1,
              'DLBackImageUrl': response2,
              'DLNumber': authController.drivingLicenceController.text.trim(),
            });

            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const VehicleRc(),
                ),
              );
            }
          }
        } else {
          showErrorSnackBar(context, 'Please fill all required fields.');
        }
      } catch (error) {
        if (context.mounted) {
          showErrorSnackBar(context, 'Error: ${error.toString()}');
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Theme.of(context).cardColor,
            appBar: AppBar(
              title: const Text('Driving Licence'),
            ),
            body: AbsorbPointer(
              absorbing: _isLoading, // Prevents interaction while loading
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
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
                        label: 'Enter Driving Licence no.',
                        hintText: 'e.g: DL-12-1234567',
                        keyboardType: TextInputType.number,
                        controller: authController.drivingLicenceController,
                        validator: (val) =>
                            Validators.validateDrivingLicence(val!),
                      ),
                      const SizedBox(height: 25),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              submitForm();
                            } else {
                              showErrorSnackBar(
                                context,
                                'Please fill all required fields.',
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CustomLoader(),
              ),
            ),
          ),
      ],
    );
  }
}
