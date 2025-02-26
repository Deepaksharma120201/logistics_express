import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_dropdown.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';
import 'package:logistics_express/src/custom_widgets/profile_picker.dart';
import 'package:logistics_express/src/features/utils/new_text_field.dart';
import 'package:logistics_express/src/features/utils/validators.dart';

class CustomerEditProfile extends ConsumerStatefulWidget {
  const CustomerEditProfile({super.key});

  @override
  ConsumerState<CustomerEditProfile> createState() =>
      _CustomerEditProfileState();
}

class _CustomerEditProfileState extends ConsumerState<CustomerEditProfile> {
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference firestore =
  FirebaseFirestore.instance.collection("customers");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _selectedGender;


  @override
  void initState() {
    super.initState();
    _fetchCustomerData();
  }

  Future<void> _fetchCustomerData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('No user logged in');
      return;
    }

    final String userId = user.uid;
    print('User ID: $userId');

    try {
      final docSnapshot = await firestore.doc(userId).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        print('Fetched data: $data');

        setState(() {
          _nameController.text = data['Name'] ?? '';
          _emailController.text = data['Email'] ?? '';
          _phoneController.text = data['Phone'] ?? '';
          _dobController.text = data['DateOfBirth'] ?? '';
          _selectedGender = data['Gender'];
        });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching customer data: $e');
    }
  }

  void _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return; // No user logged in

      final String userId = user.uid;

      try {
        await firestore.doc(userId).update({
          'Name': _nameController.text,
          'Phone': _phoneController.text,
          'DateOfBirth': _dobController.text,
          'Gender': _selectedGender,
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(title: const Text('Edit Profile')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
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
                    initialImage: _selectedImage,
                  ),
                  const SizedBox(height: 20),
                  NewTextField(
                    label: 'Name',
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    validator: (val) => Validators.validateName(val!),
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
                    validator: (val) => Validators.validatePhone(val!),
                  ),
                  NewTextField(
                    label: 'Date of Birth',
                    controller: _dobController,
                    readOnly: true,
                    hintText: 'DD/MM/YYYY',
                    onTap: () async {
                      String selectedDate = await DatePicker.pickDate(context);
                      setState(() {
                        _dobController.text = selectedDate;
                      });
                    },
                    suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                  ),
                  CustomDropdown(
                    label: "Gender",
                    items: const ['Male', 'Female'],
                    value: _selectedGender != null && ['Male', 'Female'].contains(_selectedGender)
                        ? _selectedGender
                        : null,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    validator: (val) => Validators.commonValidator(val!),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveChanges,
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}