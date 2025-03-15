import 'package:flutter/material.dart';
import 'package:logistics_express/src/utils/new_text_field.dart';

class RequestDetail extends StatelessWidget {
  final String destination;
  final String requestDate;
  final bool isPending;

  const RequestDetail({
    super.key,
    required this.destination,
    required this.requestDate,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    // Sample full data for matching
    final List<Map<String, String>> fullRequests = [
      {
        'source': 'Pune',
        'destination': 'Mumbai',
        'requestDate': '10/12/2024',
        'weight': '25',
        'volume': '1200',
        'itemType': 'Furniture',
      },
      {
        'source': 'Nagpur',
        'destination': 'Delhi',
        'requestDate': '11/12/2024',
        'weight': '15',
        'volume': '800',
        'itemType': 'Electronics',
      },
      {
        'source': 'Delhi',
        'destination': 'Jaipur',
        'requestDate': '05/12/2024',
        'weight': '300',
        'volume': '800',
        'itemType': 'Tiles,Glass',
      },
    ];

    final request = fullRequests.firstWhere(
      (r) => r['destination'] == destination && r['requestDate'] == requestDate,
      orElse: () => {},
    );

    if (request.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Request Detail")),
        body: const Center(child: Text("No request found.")),
      );
    }

    final sourceController = TextEditingController(text: request['source']);
    final destinationController =
        TextEditingController(text: request['destination']);
    final dateController = TextEditingController(text: request['requestDate']);
    final weightController = TextEditingController(text: request['weight']);
    final volumeController = TextEditingController(text: request['volume']);
    final itemTypeController = TextEditingController(text: request['itemType']);

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
              Center(
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
                    // Add cancel logic here
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
          ],
        ),
      ),
    );
  }
}
