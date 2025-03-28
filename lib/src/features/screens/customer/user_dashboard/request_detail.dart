import 'package:flutter/material.dart';
import 'package:logistics_express/src/utils/new_text_field.dart';

class RequestDetail extends StatelessWidget {
  final Map<String, dynamic> rideData;
  final bool isPending;

  const RequestDetail({
    super.key,
    required this.rideData,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    // Extract values from rideData safely.
    final String source = rideData['source']?.toString() ?? '';
    final String destination = rideData['destination']?.toString() ?? '';
    final String date = rideData['Date']?.toString() ?? '';
    final String weight = rideData['weight']?.toString() ?? '';
    final String volume = rideData['volume']?.toString() ?? '';
    final String itemType = rideData['itemType']?.toString() ?? '';

    // Create controllers for display.
    final sourceController = TextEditingController(text: source);
    final destinationController = TextEditingController(text: destination);
    final dateController = TextEditingController(text: date);
    final weightController = TextEditingController(text: weight);
    final volumeController = TextEditingController(text: volume);
    final itemTypeController = TextEditingController(text: itemType);

    return Scaffold(
      appBar: AppBar(title: const Text("Request Detail")),
      backgroundColor: Theme.of(context).cardColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            NewTextField(
              label: 'Source',
              controller: sourceController,
              readOnly: true,
            ),
            NewTextField(
              label: 'Destination',
              controller: destinationController,
              readOnly: true,
            ),
            NewTextField(
              label: 'Date',
              controller: dateController,
              readOnly: true,
            ),
            NewTextField(
              label: 'Weight (kg)',
              controller: weightController,
              readOnly: true,
              keyboardType: TextInputType.number,
            ),
            NewTextField(
              label: 'Volume (cm³)',
              controller: volumeController,
              readOnly: true,
              keyboardType: TextInputType.number,
            ),
            NewTextField(
              label: 'Item Type',
              controller: itemTypeController,
              readOnly: true,
            ),
            if (isPending)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () {
                      // Add cancel logic here.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Request cancelled')),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel Request',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
