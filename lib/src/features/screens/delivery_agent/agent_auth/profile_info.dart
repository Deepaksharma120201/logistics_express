import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/profile_picker.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/driving_licence.dart';
import 'package:logistics_express/src/features/utils/validators.dart';
import 'package:logistics_express/src/models/agent_model.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';
import 'package:logistics_express/src/services/cloudinary/cloudinary_service.dart';
import 'package:logistics_express/src/services/user_services.dart';
import 'package:logistics_express/src/features/utils/firebase_exceptions.dart';

class ProfileInfo extends ConsumerStatefulWidget {
  const ProfileInfo({super.key});

  @override
  ConsumerState<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends ConsumerState<ProfileInfo> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  File? _selectedImage;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);

    void submitForm() async {
      if (_selectedImage == null || _selectedGender == null) {
        showErrorSnackBar(context, 'Please fill all required fields.');
        return;
      }
      setState(() => _isLoading = true);

      try {
        String? imageUrl = await uploadToCloudinary(context, _selectedImage!);
        if (imageUrl == null && context.mounted) {
          showErrorSnackBar(
              context, 'Failed to upload image. Please try again.');
          return;
        }

        User? user = FirebaseAuth.instance.currentUser;
        AgentModel agent = AgentModel(
          id: user!.uid,
          name: authController.nameController.text.trim(),
          phoneNo: authController.phoneController.text.trim(),
          dateOfBirth: authController.dobController.text.trim(),
          aadhar: authController.aadharController.text.trim(),
          gender: _selectedGender!,
          profileImageUrl: imageUrl!,
        );

        final userServices = UserServices();
        await userServices.createAgent(agent);
        authController.clearAll();

        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const DrivingLicence()),
          );
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
            appBar: AppBar(title: const Text('Profile Info')),
            body: AbsorbPointer(
              absorbing: _isLoading,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ProfilePicker(
                        onImagePicked: (file) {
                          setState(() {
                            _selectedImage = file;
                          });
                        },
                        initialImage: _selectedImage,
                      ),
                      const SizedBox(height: 30),
                      FormTextField(
                        validator: (val) => Validators.validateName(val!),
                        hintText: 'Enter Name',
                        label: 'Full Name',
                        keyboardType: TextInputType.text,
                        controller: authController.nameController,
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        validator: (val) => Validators.validatePhone(val!),
                        hintText: 'Enter Phone No.',
                        label: 'Phone Number',
                        keyboardType: TextInputType.number,
                        controller: authController.phoneController,
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        readOnly: true,
                        validator: (val) => Validators.validateDate(val!),
                        hintText: 'DD/MM/YYYY',
                        label: 'Date of Birth',
                        controller: authController.dobController,
                        onTap: () async {
                          String selectedDate =
                              await DatePicker.pickDate(context);
                          setState(() {
                            authController.dobController.text = selectedDate;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      FormTextField(
                        validator: (val) => Validators.validateAadhar(val!),
                        hintText: 'Aadhar card No.',
                        label: 'Enter Aadhar card No.',
                        keyboardType: TextInputType.number,
                        controller: authController.aadharController,
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        dropdownColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        isExpanded: true,
                        hint: const Text('Select Gender'),
                        value: _selectedGender,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Male', child: Text('Male')),
                          DropdownMenuItem(
                              value: 'Female', child: Text('Female')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
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
              child: const Center(child: CustomLoader()),
            ),
          ),
      ],
    );
  }
}
