import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/update_ride.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';

class PublishedRide extends StatefulWidget {
  const PublishedRide({super.key});

  @override
  State<PublishedRide> createState() {
    return _PublishedRideScreenState();
  }
}

class _PublishedRideScreenState extends State<PublishedRide> {
  List<Map<String, dynamic>> publishedRides = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllRides();
  }

  Future<void> fetchAllRides() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    List<Map<String, dynamic>> rides = [];
    setState(() => isLoading = true);

    try {
      QuerySnapshot rideDocs = await fireStore
          .collection("published-rides")
          .doc(user!.uid)
          .collection("rides") // Sub-collection for deliveries
          .get();

      for (var doc in rideDocs.docs) {
        rides.add(doc.data() as Map<String, dynamic>);
      }

      // Sort rides based on StartDate
      rides.sort((a, b) {
        List<String> dateA = a["StartDate"].split("/");
        List<String> dateB = b["StartDate"].split("/");

        DateTime parsedDateA = DateTime(
            int.parse(dateA[2]), int.parse(dateA[1]), int.parse(dateA[0]));
        DateTime parsedDateB = DateTime(
            int.parse(dateB[2]), int.parse(dateB[1]), int.parse(dateB[0]));

        return parsedDateA.compareTo(parsedDateB);
      });

      setState(() {
        publishedRides = rides;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      showErrorSnackBar(context, "Error fetching rides: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Published Ride'),
          ),
          backgroundColor: Theme.of(context).cardColor,
          body: isLoading
              ? Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: const Center(
                      child: CustomLoader(),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: publishedRides.length,
                  itemBuilder: (context, index) {
                    final ride = publishedRides[index];
                    return InfoRides(
                      rideId: shortenUUID(ride['id']),
                      date: ride['StartDate'],
                      ride: ride,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class InfoRides extends StatelessWidget {
  const InfoRides({
    super.key,
    required this.date,
    required this.rideId,
    required this.ride,
  });

  final String date;
  final String rideId;
  final Map<String, dynamic> ride;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Ride id - $rideId'),
        subtitle: Text('Date - $date'),
        trailing: const Icon(FontAwesomeIcons.arrowRight),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateRide(ride: ride),
            ),
          );
        },
      ),
    );
  }
}
