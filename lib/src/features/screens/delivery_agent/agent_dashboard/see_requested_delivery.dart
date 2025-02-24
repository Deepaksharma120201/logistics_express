import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';

class SeeRequestedDelivery extends StatelessWidget {
  final List<Map<String, String>> rides = [
    {
      "from": "Kurukshetra",
      "to": "Delhi",
      "rideDate": "12/02/2025",
      "rideId": "001",
      "userName": "Deepak",
      "userAddress": "98, Vishram Nagar, Delhi",
      "cargoType": "Glass, Wood",
      "cargoWeight": "82kg",
      "cargoVolume": "2.5m³",
    },
    {
      "from": "Jind",
      "to": "Karnal",
      "rideDate": "13/02/2025",
      "rideId": "002",
      "userName": "Amit",
      "userAddress": "45, Model Town, Karnal",
      "cargoType": "Electronics",
      "cargoWeight": "50kg",
      "cargoVolume": "1.2m³",
    }
  ];

  SeeRequestedDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('See Requested Delivery'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: rides.isNotEmpty
          ? RequestedRides(rides: rides)
          : const Center(
              child: Text(
                "No Available Rides",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
    );
  }
}

class RequestedRides extends StatelessWidget {
  final List<Map<String, String>> rides;

  const RequestedRides({super.key, required this.rides});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('From: ${ride['from']} \nTo: ${ride['to']}'),
            trailing: Text(
              '${ride['rideDate']}',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestedRide(ride: ride),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
