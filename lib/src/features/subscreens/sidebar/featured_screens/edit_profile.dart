import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_dropdown.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';
import 'package:logistics_express/src/custom_widgets/profile_picker.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/user_dashboard_screen.dart';
import 'package:logistics_express/src/services/authentication/auth_service.dart';
import 'package:logistics_express/src/utils/new_text_field.dart';
import 'package:logistics_express/src/utils/validators.dart';
import '../../../../custom_widgets/custom_loader.dart';
import '../../../../services/cloudinary/cloudinary_service.dart';
import '../../../../utils/firebase_exceptions.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  File? _selectedImage;
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  String? _existingProfileUrl;
  final AuthService _authService = AuthService();
  late CollectionReference firestore;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    setState(() => isLoading = true);
    try {
      final userInfo = await _authService.getUserRole(user!.uid, context);
      final String role = userInfo['role'];

      setState(() {
        firestore = FirebaseFirestore.instance
            .collection(role == 'Customer' ? 'customers' : 'agents');
      });
      await _fetchCustomerData();
    } catch (e) {
      showErrorSnackBar(context, 'Error initializing user data: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _fetchCustomerData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    try {
      final docSnapshot = await firestore.doc(user!.uid).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _nameController.text = data['Name'] ?? '';
          _emailController.text = data['Email'] ?? '';
          _phoneController.text = data['Phone'] ?? '';
          _dobController.text = data['Date'] ?? '';
          _selectedGender = data['Gender'];
          _existingProfileUrl = data['ProfileImageUrl'];
        });
      } else {
        showErrorSnackBar(context, 'Document does not exist');
      }
    } catch (e) {
      print(firestore);
      showErrorSnackBar(context, 'Error fetching customer data: $e');
    }
  }

  void _saveChanges() async {
    setState(() => isLoading = true);
    final User? user = FirebaseAuth.instance.currentUser;
    String? response = _existingProfileUrl;
    
    if (_selectedImage != null) {
      response = await uploadToCloudinary(context, _selectedImage!);
    }
    try {
      await firestore.doc(user!.uid).update({
        'Name': _nameController.text,
        'Phone': _phoneController.text,
        'Date': _dobController.text,
        'Gender': _selectedGender,
        'ProfileImageUrl': response,
      });

      showSuccessSnackBar(context, 'Profile updated successfully!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserHomeScreen(),
        ),
      );
    } catch (e) {
      showErrorSnackBar(context, 'Error updating profile: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).cardColor,
            appBar: AppBar(title: const Text('Edit Profile')),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: AbsorbPointer(
                absorbing: isLoading,
                child: SingleChildScrollView(
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
                          // initialImage: _existingProfileUrl,
                        ),
                        const SizedBox(height: 20),
                        NewTextField(
                          label: 'Name',
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          validator: (val) => Validators.validateName(val),
                        ),
                        NewTextField(
                          label: 'Email',
                          controller: _emailController,
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        NewTextField(
                          label: 'Phone',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (val) => Validators.validatePhone(val),
                        ),
                        NewTextField(
                          label: 'Date of Birth',
                          controller: _dobController,
                          readOnly: true,
                          hintText: 'DD/MM/YYYY',
                          onTap: () async {
                            String selectedDate =
                                await DatePicker.pickDate(context);
                            setState(() {
                              _dobController.text = selectedDate;
                            });
                          },
                          suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                        ),
                        CustomDropdown(
                          label: "Gender",
                          items: const ['Male', 'Female'],
                          value: _selectedGender != null &&
                                  ['Male', 'Female'].contains(_selectedGender)
                              ? _selectedGender
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveChanges();
                              } else {
                                showErrorSnackBar(
                                  context,
                                  "Please fill all fields!",
                                );
                              }
                            },
                            child: const Text('Save Changes'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: CustomLoader(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
