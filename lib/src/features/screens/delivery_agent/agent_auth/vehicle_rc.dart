import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/agent_dashboard_screen.dart';
import 'package:logistics_express/src/features/utils/firebase_exceptions.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/image_picker.dart';
import 'package:logistics_express/src/features/utils/validators.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';
import 'package:logistics_express/src/services/cloudinary/cloudinary_service.dart';

class VehicleRc extends ConsumerStatefulWidget {
  const VehicleRc({super.key});

  @override
  ConsumerState<VehicleRc> createState() => _VehicleRcState();
}

class _VehicleRcState extends ConsumerState<VehicleRc> {
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
          String? response2 = await uploadToCloudinary(context, _backImage!);

          if (response1 != null && response2 != null) {
            User? user = FirebaseAuth.instance.currentUser;
            await FirebaseFirestore.instance
                .collection('agents')
                .doc(user!.uid)
                .update({
              'RCFrontImageUrl': response1,
              'RCBackImageUrl': response2,
              'RCNumber': authController.drivingLicenceController.text.trim(),
            });

            await FirebaseFirestore.instance
                .collection('user_auth')
                .doc(user.uid)
                .update({
              'isCompleted': true,
            });

            if (context.mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AgentHomeScreen(),
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
              title: const Text('Vehicle RC'),
            ),
            body: AbsorbPointer(
              absorbing: _isLoading,
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
                        label: 'Enter Vehicle RC no.',
                        hintText: 'e.g: AB12CD1234',
                        keyboardType: TextInputType.number,
                        controller: authController.vehicleRcController,
                        validator: (val) => Validators.validateVehicleRc(val!),
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
