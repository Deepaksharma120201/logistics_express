import 'package:flutter/material.dart';
import 'package:logistics_express/src/theme/theme.dart';

class AvailableRides extends StatelessWidget {
  const AvailableRides({
    super.key,
    required this.source,
    required this.destination,
  });

  final String source;
  final String destination;

  @override
  Widget build(BuildContext context) {
    // Sample data for rides
    final List<Map<String, String>> availableRides = [
      {'rideId': '111', 'date': '12/12/2024'},
      {'rideId': '222', 'date': '13/12/2024'},
      {'rideId': '333', 'date': '14/12/2024'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rides'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display the source information
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: kColorScheme.secondaryContainer.withOpacity(1),
              // borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kColorScheme.primary),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  source,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                ),
                const Text(
                  'To',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                ),
                Text(
                  destination,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: availableRides.isNotEmpty
                ? ListView.builder(
                    itemCount: availableRides.length,
                    itemBuilder: (context, index) {
                      final ride = availableRides[index];
                      return InfoRides(
                        rideId: ride['rideId']!,
                        date: ride['date']!,
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No Available Rides,You can make request for ride',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class InfoRides extends StatelessWidget {
  const InfoRides({
    super.key,
    required this.date,
    required this.rideId,
  });

  final String date;
  final String rideId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: kColorScheme.secondaryContainer.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Ride Id-$rideId'),
          Text(date),
        ],
      ),
    );
  }
}
