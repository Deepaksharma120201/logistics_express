import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/ride_info_track_delivery.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';

class TrackDeliveryScreen extends StatefulWidget {
  const TrackDeliveryScreen({super.key});

  @override
  State<TrackDeliveryScreen> createState() => _TrackDeliveryScreenState();
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  int selectedTabIndex = 0;
  bool isLoading = true;

  // now dynamic lists—not hard-coded
  List<Map<String, dynamic>> activeRides = [];
  List<Map<String, dynamic>> completedRides = [];

  @override
  void initState() {
    super.initState();
    fetchRides();
  }

  Future<void> fetchRides() async {
    final fireStore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // fetch active (accepted) rides
      final activeSnapshot = await fireStore
          .collection("requested-deliveries")
          .doc(user.uid)
          .collection("deliveries")
          .where('IsPending', isEqualTo: false)
          .get();

      // fetch completed rides
      final completedSnapshot = await fireStore
          .collection("requested-deliveries")
          .doc(user.uid)
          .collection("deliveries")
          .where('IsDelivered', isEqualTo: true)
          .get();

      // map docs ➞ List<Map<String,dynamic>>, preserving rideId for display
      final act = activeSnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      final comp = completedSnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      setState(() {
        activeRides = act;
        completedRides = comp;
        isLoading = false;
      });
    } catch (e) {
      // handle or log error as needed
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // choose which list to show
    final rides = selectedTabIndex == 0 ? activeRides : completedRides;

    return Scaffold(
      appBar: AppBar(title: const Text('Track Delivery')),
      backgroundColor: Theme.of(context).cardColor,
      body: isLoading
      // simple loading indicator while fetching
          ? const Center(child: CircularProgressIndicator())
          : rides.isEmpty
          ? Center(
        child: Text(
          selectedTabIndex == 0
              ? "No active deliveries"
              : "No completed deliveries",
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
          setState(() {
            selectedTabIndex = index;
          });
        },
      ),
    );
  }
}

class DeliveryList extends StatelessWidget {
  final List<Map<String, dynamic>> rides;

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
            title: Text('Ride id - ${shortenUUID(delivery['id'])}'),
            subtitle: Text('Ride date - ${delivery['Date']}'),
            trailing: const Icon(FontAwesomeIcons.arrowRight),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RideInformationScreen(ride: delivery),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
