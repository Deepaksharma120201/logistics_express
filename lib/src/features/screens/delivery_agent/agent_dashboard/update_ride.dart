import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import '../../../../custom_widgets/date_picker.dart';
import '../../../../utils/new_text_field.dart';
import '../../../../utils/validators.dart';

class UpdateRide extends StatefulWidget {
  const UpdateRide({
    super.key,
    required this.ride,
  });

  final Map<String, dynamic> ride;
  @override
  State<UpdateRide> createState() => _UpdateRideState();
}

class _UpdateRideState extends State<UpdateRide> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDateController.text = widget.ride['StartDate'];
    _endDateController.text = widget.ride['EndDate'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Ride - ID: ${shortenUUID(widget.ride['id'])}'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AddressFilled(),
              const SizedBox(height: 30),
              NewTextField(
                hintText: "DD/MM/YYYY",
                label: 'Start Date',
                keyboardType: TextInputType.number,
                controller: _startDateController,
                readOnly: true,
                onTap: () async {
                  String selectedDate = await DatePicker.pickDate(context);
                  setState(() {
                    _startDateController.text = selectedDate;
                  });
                },
                suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                validator: (val) => Validators.validateDate(val!),
              ),
              const SizedBox(height: 10),
              NewTextField(
                hintText: "DD/MM/YYYY",
                label: 'End Date',
                controller: _endDateController,
                keyboardType: TextInputType.number,
                readOnly: true,
                onTap: () async {
                  String selectedDate = await DatePicker.pickDate(context);
                  setState(() {
                    _endDateController.text = selectedDate;
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
      ),
    );
  }
}
