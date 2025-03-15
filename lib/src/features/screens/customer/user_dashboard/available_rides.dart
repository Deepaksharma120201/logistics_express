import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/ride_information_screen_of_SR.dart';
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
      for (var doc in rideDocs.docs) {
        rides.add(doc.data() as Map<String, dynamic>);
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
          // Display the source and destination
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
                      Text(
                        "FROM : ${widget.source}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "TO : ${widget.destination}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: isLoading
                ? Center(
                    child: CustomLoader(),
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
                    : const Center(
                        child: Text(
                          'No Available Rides, You can make a request for a ride',
                          textAlign: TextAlign.center,
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
    return Card(
      child: ListTile(
        title: Text('Ride id - $rideId'),
        subtitle: Text('Date - $date'),
        trailing: const Icon(FontAwesomeIcons.arrowRight),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>RideInformationSR(
            rideId: rideId,
            rideDate:date,
          )
          ));
        },
      ),
    );
  }
}
