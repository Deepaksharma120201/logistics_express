import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_dropdown.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';
import 'package:logistics_express/src/custom_widgets/profile_picker.dart';
import 'package:logistics_express/src/features/utils/new_text_field.dart';
import 'package:logistics_express/src/features/utils/validators.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController(text: "Username");
  final TextEditingController _emailController =
      TextEditingController(text: "abc@gmail.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "1234567890");
  final TextEditingController _dobController = TextEditingController();

  String? _selectedGender;
  void _saveChanges() {}

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
                    hintText: "DD/MM/YYYY",
                    label: 'Date of Birth',
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    onTap: () async {
                      String selectedDate = await DatePicker.pickDate(context);
                      setState(() {
                        _dobController.text = selectedDate;
                      });
                    },
                    suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                    validator: (val) => Validators.validateDate(val!),
                  ),
                  CustomDropdown(
                    label: "Gender",
                    items: ['Male', 'Female'],
                    value: _selectedGender,
                    onChanged: (value) =>
                        setState(() => _selectedGender = value),
                    validator: (val) => Validators.validateDropdown(val!),
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
