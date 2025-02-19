import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/custom_widgets/custom_dropdown.dart';
import '../../../utils/new_text_field.dart';
import '../../../utils/validators.dart';

class PublishRide extends StatefulWidget {
  const PublishRide({super.key});

  @override
  State<PublishRide> createState() => _PublishRideState();
}

class _PublishRideState extends State<PublishRide> {
  String? _dropdownValue;
  final TextEditingController _dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish Ride'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AddressFilled(),
              const SizedBox(height: 20),
              NewTextField(
                hintText: "DD/MM/YYYY",
                label: 'Start Date',
                controller: _dobController,
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
              const SizedBox(height: 10),
              NewTextField(
                hintText: "DD/MM/YYYY",
                label: 'End Date',
                controller: _dobController,
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
              const SizedBox(height: 10),
              NewTextField(
                label: 'Name',
                hintText: 'Enter name',
                validator: (val) => Validators.validateName(val!),
              ),
              SizedBox(height: 10),
              NewTextField(
                label: 'Phone Number',
                hintText: 'Enter phone number',
                validator: (val) => Validators.validatePhone(val!),
              ),
              SizedBox(height: 10),
              CustomDropdown(
                label: 'Vehicle Type',
                items: [
                  'Pickup Truck',
                  'Mini Truck',
                  'Small Cargo Van',
                  'Rigid Truck'
                ],
                value: _dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownValue = newValue;
                  });
                },
                validator: (String? value) {
                  if (value == null) {
                    return 'Please select a vehicle type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Center(
                  child: ElevatedButton(
                      onPressed: () {}, child: Text('Publish Ride')))
            ],
          ),
        ),
      ),
    );
  }
}
