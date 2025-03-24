import 'package:flutter/material.dart';

class RequestedRide extends StatelessWidget {
  final Map<String, dynamic> delivery;

  const RequestedRide({
    super.key,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Requested Delivery")),
      backgroundColor: Theme.of(context).cardColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${delivery['Source']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            Text('To: ${delivery['Destination']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            Text('Requested Date: ${delivery['Date']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 24),
            Text('Customer Name: ${delivery['Name']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            Text('Phone no.: ${delivery['Phone']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 24),
            Text(
              'Cargo Information:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Type: ${delivery['ItemType']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Weight: ${delivery['Weight']} kg',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Volume: ${delivery['Volume']} cm\u00B3',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
