import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_dialog.dart';
import 'package:logistics_express/src/custom_widgets/custom_dropdown.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import 'package:logistics_express/src/utils/theme.dart';
import 'package:logistics_express/src/utils/validators.dart';
import '../../../../utils/new_text_field.dart';

class RideInformationSR extends StatefulWidget {
  final Map<String, dynamic> ride;

  const RideInformationSR({
    super.key,
    required this.ride,
  });

  @override
  State<RideInformationSR> createState() => _RideInformationSRState();
}

class _RideInformationSRState extends State<RideInformationSR> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  String? _selectedType;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showRequestBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text("Enter Package Details",
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 15),
                NewTextField(
                  label: 'Weight',
                  hintText: 'Enter weight in Kg',
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  validator: (val) => Validators.quantityValidator(val),
                ),
                const SizedBox(height: 10),
                NewTextField(
                  label: 'Volume',
                  hintText: 'Enter volume in cm\u00B3',
                  keyboardType: TextInputType.number,
                  controller: volumeController,
                  validator: (val) => Validators.quantityValidator(val),
                ),
                const SizedBox(height: 10),
                CustomDropdown(
                  label: "Item Type",
                  items: [
                    'Furniture',
                    'Electronics',
                    'Clothes & Accessories',
                    'Glass & Fragile Items',
                    'Food & Medicine'
                  ],
                  value: _selectedType,
                  onChanged: (value) => setState(() => _selectedType = value),
                  validator: (val) => Validators.commonValidator(val),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      showConfirmationDialog();
                    }
                  },
                  child: const Text("Submit"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Are you sure?',
          message: 'Do you want to send the request?',
          onConfirm: () {
            Navigator.pop(context);
            sendRequest();
          },
        );
      },
    );
  }

  Future<void> sendRequest() async {
    String weight = weightController.text;
    String volume = volumeController.text;
    String itemType = _selectedType ?? "Unknown";

    // print("Request Sent: Weight - $weight, Volume - $volume, Type - $itemType");

    showSuccessSnackBar(context, "Request sent successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ride Details")),
      backgroundColor: theme.cardColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: theme.colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSectionTitle(title: "Current Ride Details"),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.locationDot,
                      text: "From: ${widget.ride['Source']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.mapPin,
                      text: "To: ${widget.ride['Destination']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.calendarDays,
                      text: "Start Date: ${widget.ride['StartDate']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.calendarDays,
                      text: "End Date: ${widget.ride['EndDate']}",
                    ),
                    const Divider(thickness: 1, height: 20),
                    CustomSectionTitle(title: "Delivery Agent Details"),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.user,
                      text: "Name: ${widget.ride['Name']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.phone,
                      text: "Phone: ${widget.ride['Phone']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.truck,
                      text: "Vehicle Type: ${widget.ride['VehicleType']}",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: showRequestBottomSheet,
                child: const Text('Send request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
