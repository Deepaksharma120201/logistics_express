import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/ride_info_track_delivery.dart';

class TrackDelivery extends StatefulWidget {
  const TrackDelivery({super.key});

  @override
  State<TrackDelivery> createState() {
    return _TrackDeliveryState();
  }
}

class _TrackDeliveryState extends State<TrackDelivery> {
  int selectedTabIndex = 0;

  final List<Map<String, String>> activeRides = [
    {
      'rideId': '1234',
      'Date': '10/12/2024',
      'Source': 'New York',
      'Destination': 'Boston',
    },
    {
      'rideId': '1235',
      'Date': '11/12/2024',
      'Source': 'Chicago',
      'Destination': 'Detroit',
    },
  ];

  final List<Map<String, String>> completedRides = [
    {
      'rideId': '1221',
      'Date': '05/12/2024',
      'Source': 'Los Angeles',
      'Destination': 'San Francisco',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Delivery'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: selectedTabIndex == 0
          ? DeliveryList(rides: activeRides)
          : DeliveryList(rides: completedRides),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Theme.of(context).primaryColor,
        destinations: const [
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.truck),
            label: 'Active',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.listCheck),
            label: 'Completed',
          ),
        ],
        selectedIndex: selectedTabIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedTabIndex = index;
          });
        },
      ),
    );
  }
}

class DeliveryList extends StatelessWidget {
  final List<Map<String, String>> rides;

  const DeliveryList({
    super.key,
    required this.rides,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final delivery = rides[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('Ride id - ${delivery['rideId']}'),
            subtitle: Text('Ride date - ${delivery['Date']}'),
            trailing: const Icon(FontAwesomeIcons.arrowRight),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RideInformationScreen(
                    ride: rides[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
