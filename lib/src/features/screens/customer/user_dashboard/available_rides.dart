import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/ride_info_search_ride.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import 'package:logistics_express/src/utils/theme.dart';

class AvailableRides extends StatefulWidget {
  const AvailableRides({
    super.key,
    required this.source,
    required this.destination,
  });

  final String source;
  final String destination;

  @override
  State<AvailableRides> createState() => _AvailableRidesState();
}

class _AvailableRidesState extends State<AvailableRides> {
  List<Map<String, dynamic>> availableRides = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllRides();
  }

  Future<void> fetchAllRides() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> rides = [];

    try {
      QuerySnapshot rideDocs = await fireStore.collectionGroup("rides").get();
      DateTime today = DateTime.now();
      DateTime todayOnly =
          DateTime(today.year, today.month, today.day); // Remove time

      for (var doc in rideDocs.docs) {
        Map<String, dynamic> rideData = doc.data() as Map<String, dynamic>;

        List<String> dateParts = rideData["StartDate"].split("/");
        DateTime rideStartDate = DateTime(
          int.parse(dateParts[2]), // Year
          int.parse(dateParts[1]), // Month
          int.parse(dateParts[0]), // Day
        );

        if (rideStartDate.isAfter(todayOnly) ||
            rideStartDate.isAtSameMomentAs(todayOnly)) {
          rides.add(rideData);
        }
      }

      setState(() {
        availableRides = rides;
        availableRides.sort((a, b) {
          List<String> dateA = a["StartDate"].split("/");
          List<String> dateB = b["StartDate"].split("/");

          DateTime parsedDateA = DateTime(
              int.parse(dateA[2]), int.parse(dateA[1]), int.parse(dateA[0]));
          DateTime parsedDateB = DateTime(
              int.parse(dateB[2]), int.parse(dateB[1]), int.parse(dateB[0]));

          return parsedDateA.compareTo(parsedDateB);
        });
        isLoading = false;
      });
    } catch (e) {
      showErrorSnackBar(
        context,
        "Error fetching rides: $e",
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Rides')),
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: kColorScheme.secondaryContainer.withOpacity(1),
              border: Border.all(color: kColorScheme.primary),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInfoRow(
                        icon: FontAwesomeIcons.locationDot,
                        text: "From : ${widget.source}",
                      ),
                      CustomInfoRow(
                        icon: FontAwesomeIcons.mapPin,
                        text: "To : ${widget.destination}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: const Center(
                        child: CustomLoader(),
                      ),
                    ),
                  )
                : availableRides.isNotEmpty
                    ? ListView.builder(
                        itemCount: availableRides.length,
                        itemBuilder: (context, index) {
                          final ride = availableRides[index];
                          return InfoRides(
                            rideId: shortenUUID(ride['id']),
                            date: ride['StartDate'],
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'No Available Rides, You can make a request for a ride',
                          style: Theme.of(context).textTheme.headlineMedium,
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
    return Card(
      child: ListTile(
        title: Text('Ride id - $rideId'),
        subtitle: Text('Date - $date'),
        trailing: const Icon(FontAwesomeIcons.arrowRight),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RideInformationSR(
                rideId: rideId,
                rideDate: date,
              ),
            ),
          );
        },
      ),
    );
  }
}
