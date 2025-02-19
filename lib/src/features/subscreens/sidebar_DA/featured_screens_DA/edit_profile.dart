import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_dropdown.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';
import 'package:logistics_express/src/features/utils/new_text_field.dart';
import 'package:logistics_express/src/features/utils/validators.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
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
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                NewTextField(
                  label: 'Name',
                  controller: _nameController,
                  validator: (val) => Validators.validateName(val!),
                ),
                NewTextField(
                  label: 'Email',
                  controller: _emailController,
                  readOnly: true,
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
                  controller: _dobController,
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
                  onChanged: (value) => setState(() => _selectedGender = value),
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
    );
  }
}
