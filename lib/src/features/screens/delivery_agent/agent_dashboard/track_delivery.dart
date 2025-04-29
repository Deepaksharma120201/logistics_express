import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/ride_info_track_delivery.dart';

import '../../../../utils/firebase_exceptions.dart';

class TrackDelivery extends StatefulWidget {
  const TrackDelivery({Key? key}) : super(key: key);

  @override
  State<TrackDelivery> createState() => _TrackDeliveryState();
}

class _TrackDeliveryState extends State<TrackDelivery> {
  int selectedTabIndex = 0;
  bool isLoading = true;

  // dynamic lists fetched from Firestore
  List<Map<String, dynamic>> activeRides = [];
  List<Map<String, dynamic>> completedRides = [];

  @override
  void initState() {
    super.initState();
    fetchRides();
  }

  Future<void> fetchRides() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      // 1. Get the agent's Uuid from their Agent document
      final agentSnap = await FirebaseFirestore.instance
          .collection('agents')
          .doc(user.uid)
          .get();
      final agentId = agentSnap.get('id') as String;

      // 2A. Query active deliveries (assigned but not yet delivered)
      final activeSnap = await FirebaseFirestore.instance
          .collection('requested-deliveries')
          .doc()
          .collection('deliveries')
          .where('Did', isEqualTo: agentId)
          .where('IsDelivered', isEqualTo: false)
          .get();

      // 2B. Query completed deliveries
      final completedSnap = await FirebaseFirestore.instance
          .collection('deliveries')
          .where('Did', isEqualTo: agentId)
          .where('IsDelivered', isEqualTo: true)
          .get();

      // 3. Map Firestore docs → local maps, injecting the document ID
      final act = activeSnap.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      final comp = completedSnap.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      // 4. Update state
      setState(() {
        activeRides = act;
        completedRides = comp;
        isLoading = false;
      });
    } catch (e) {
      // handle/log error
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // choose which list to display
    final rides = selectedTabIndex == 0 ? activeRides : completedRides;

    return Scaffold(
      appBar: AppBar(title: const Text('Track Delivery')),
      backgroundColor: Theme.of(context).cardColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : rides.isEmpty
          ? Center(
        child: Text(
          selectedTabIndex == 0
              ? 'No active deliveries'
              : 'No completed deliveries',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      )
          : DeliveryList(rides: rides),
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
          setState(() => selectedTabIndex = index);
        },
      ),
    );
  }
}

class DeliveryList extends StatelessWidget {
  final List<Map<String, dynamic>> rides;

  const DeliveryList({Key? key, required this.rides}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final delivery = rides[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('Ride id - ${shortenUUID(delivery['id'])}'),
            subtitle: Text('Date - ${delivery['Date']}'),
            trailing: const Icon(FontAwesomeIcons.arrowRight),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RideInformationScreen(ride: delivery),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
