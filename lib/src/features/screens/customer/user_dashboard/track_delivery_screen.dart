import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/ride_information_screen.dart';

class TrackDeliveryScreen extends StatefulWidget {
  const TrackDeliveryScreen({super.key});

  @override
  State<TrackDeliveryScreen> createState() {
    return _TrackDeliveryScreenState();
  }
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  int selectedTabIndex = 0;

  final List<Map<String, String>> activeRides = [
    {'rideId': '1234', 'rideDate': '10/12/2024'},
    {'rideId': '1235', 'rideDate': '11/12/2024'},
  ];

  final List<Map<String, String>> completedRides = [
    {'rideId': '1221', 'rideDate': '05/12/2024'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Delivery'),
      ),
      backgroundColor: Colors.white,
      body: selectedTabIndex == 0
          ? DeliveryList(rides: activeRides)
          : DeliveryList(rides: completedRides),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Theme.of(context).focusColor,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_shipping),
            label: 'Active',
          ),
          NavigationDestination(
              icon: Icon(Icons.check_circle), label: 'Completed'),
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

  const DeliveryList({super.key, required this.rides});

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
            subtitle: Text('Ride date - ${delivery['rideDate']}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RideInformationScreen(
                    rideId: delivery['rideId']!,
                    rideDate: delivery['rideDate']!,
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
