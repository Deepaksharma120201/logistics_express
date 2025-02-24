import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';

class UpdateRide extends StatefulWidget {
  const UpdateRide({super.key});

  @override
  State<UpdateRide> createState() => _UpdateRideState();
}

class _UpdateRideState extends State<UpdateRide> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            _buildLabel('Start Date'),
            _buildDatePickerField(_startDateController),
            const SizedBox(height: 30),
            _buildLabel('End Date'),
            _buildDatePickerField(_endDateController),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildDatePickerField(TextEditingController controller) {
    return GestureDetector(
      onTap: () async {
        String selectedDate = await DatePicker.pickDate(context);
        setState(() {
          controller.text = selectedDate;
        });
      },
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "DD/MM/YYYY",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
