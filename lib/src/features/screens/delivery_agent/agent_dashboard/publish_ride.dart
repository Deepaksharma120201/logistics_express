import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/custom_widgets/custom_dropdown.dart';
import 'package:logistics_express/src/theme/theme.dart';
import '../../../../custom_widgets/form_text_field.dart';
import '../../../utils/validators.dart';

class PublishRide extends StatefulWidget {
  const PublishRide({super.key});

  @override
  State<PublishRide> createState() => _PublishRideState();
}

class _PublishRideState extends State<PublishRide> {
  String? _dropdownValue; // Nullable type for initial value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish Ride'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddressFilled(),
            const SizedBox(height: 30),
            FormTextField(
              readOnly: true,
              validator: (val) => Validators.validateDate(val!),
              hintText: 'DD/MM/YYYY',
              label: 'Start Date',
              onTap: () async {
                String selectedDate = await DatePicker.pickDate(context);
              },
              suffixIcon: IconButton(
                  onPressed: () async {
                    String selectedDate = await DatePicker.pickDate(context);
                  },
                  icon: Icon(
                    FontAwesomeIcons.calendarDays,
                    color: theme.primaryColor,
                  )),
              ),
            const SizedBox(height: 30),
            FormTextField(
              readOnly: true,
              validator: (val) => Validators.validateDate(val!),
              hintText: 'DD/MM/YYYY',
              label: 'End Date',
              onTap: () async {
                String selectedDate = await DatePicker.pickDate(context);
              },
              suffixIcon: IconButton(
                  onPressed: () async {
                    String selectedDate = await DatePicker.pickDate(context);
                  },
                  icon: Icon(
                    FontAwesomeIcons.calendarDays,
                    color: theme.primaryColor,
                  )),
            ),
            const SizedBox(height: 30),
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
            SizedBox(height: 30),
            FormTextField(
              label: 'Name',
              hintText: 'Enter your name here',
            ),
            SizedBox(
              height: 30,
            ),
            FormTextField(
              label: 'Phone Number',
              hintText: 'Enter your phone number here',
              validator: (val) => Validators.validateEmail(val),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {}, child: Text('Publish Ride')))
          ],
        ),
      ),
    );
  }
}
