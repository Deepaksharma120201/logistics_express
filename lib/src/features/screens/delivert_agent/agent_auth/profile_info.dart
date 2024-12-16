import 'package:flutter/material.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/validators.dart';
import 'package:logistics_express/src/features/screens/delivert_agent/agent_auth/driving_licence.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          title: const Text('Profile Info'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 180,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 20,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              FormTextField(
                validator: (val) => Validators.validateName(val!),
                hintText: 'Enter Name',
                label: 'Full Name',
                icon: const Icon(Icons.person),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              FormTextField(
                validator: (val) => Validators.validatePhone(val!),
                hintText: 'Enter Phone No.',
                label: 'Phone Number',
                icon: const Icon(Icons.phone),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              FormTextField(
                // validator: (val) => Validators.validateName(val!),
                hintText: 'DD/MM/YYYY',
                label: 'Date of Birth',
                icon: const Icon(Icons.calendar_month),
                keyboardType: TextInputType.datetime,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_month),
                ),
              ),
              const SizedBox(height: 20),
              FormTextField(
                // validator: (val) => Validators.validateName(val!),
                hintText: 'Aadhar card No.',
                label: 'Enter Aadhar card No.',
                icon: const Icon(Icons.perm_identity),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    dropdownColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    isExpanded: true,
                    hint: Text('Select Gender'),
                    items: [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DrivingLicence(),
                      ),
                    );
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
