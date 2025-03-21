import 'package:flutter/material.dart';

class RequestedRide extends StatelessWidget {
  final Map<String, String> ride;

  const RequestedRide({super.key, required this.ride});

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
            Text('From: ${ride['from']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('To: ${ride['to']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Requested Date: ${ride['rideDate']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('User Name: ${ride['userName']}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('User Address: ${ride['userAddress']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Cargo Information:',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Type: ${ride['cargoType']}',
                style: const TextStyle(fontSize: 18)),
            Text('Weight: ${ride['cargoWeight']}',
                style: const TextStyle(fontSize: 18)),
            Text('Volume: ${ride['cargoVolume']}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}




