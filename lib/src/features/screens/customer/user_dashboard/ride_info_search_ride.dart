import 'package:flutter/material.dart';

class RideInformationSR extends StatelessWidget {
  final String rideId;
  final String rideDate;

  const RideInformationSR({
    super.key,
    required this.rideId,
    required this.rideDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Ride Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ride id: $rideId',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ride Start date: $rideDate',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Ride End date: 23/05/25',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Driver Information:',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Driver Name: Akash',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Driver Contact: 9440123456',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Vehicle Type: Small Truck',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Send Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
