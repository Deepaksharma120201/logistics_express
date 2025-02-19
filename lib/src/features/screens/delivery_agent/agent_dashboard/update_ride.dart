import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';

import '../../../../custom_widgets/date_picker.dart';
import '../../../utils/new_text_field.dart';
import '../../../utils/validators.dart';

class UpdateRide extends StatefulWidget {
  const UpdateRide({super.key});

  @override
  State<UpdateRide> createState() => _UpdateRideState();
}

class _UpdateRideState extends State<UpdateRide> {
  final TextEditingController _dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TextEditingController dobController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Ride'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddressFilled(),
            const SizedBox(height: 30),
            NewTextField(
              hintText: "DD/MM/YYYY",
              label: 'Start Date',
              keyboardType: TextInputType.number,
              controller: _dobController,
              readOnly: true,
              onTap: () async {
                String selectedDate = await DatePicker.pickDate(context);
                setState(() {
                  dobController.text = selectedDate;
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
                  dobController.text = selectedDate;
                });
              },
              suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
              validator: (val) => Validators.validateDate(val!),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Update Ride'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
