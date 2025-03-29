import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';

class SeeRequestedDelivery extends StatefulWidget {
  const SeeRequestedDelivery({super.key});

  @override
  State<SeeRequestedDelivery> createState() => _SeeRequestedDeliveryState();
}

class _SeeRequestedDeliveryState extends State<SeeRequestedDelivery> {
  List<Map<String, dynamic>> requestedDeliveries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllDeliveries();
  }

  Future<void> fetchAllDeliveries() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;

    List<Map<String, dynamic>> rides = [];

    try {
      QuerySnapshot rideDocs =
          await fireStore.collectionGroup("deliveries").get();
      DateTime today = DateTime.now();
      DateTime todayOnly =
          DateTime(today.year, today.month, today.day); // Remove time

      for (var doc in rideDocs.docs) {
        Map<String, dynamic> rideData = doc.data() as Map<String, dynamic>;

        List<String> dateParts = rideData["Date"].split("/");
        DateTime rideStartDate = DateTime(
          int.parse(dateParts[2]), // Year
          int.parse(dateParts[1]), // Month
          int.parse(dateParts[0]), // Day
        );

        if (rideData['IsPending'] &&
            (rideStartDate.isAfter(todayOnly) ||
                rideStartDate.isAtSameMomentAs(todayOnly))) {
          rides.add(rideData);
        }
      }

      setState(() {
        requestedDeliveries = rides;
        requestedDeliveries.sort((a, b) {
          List<String> dateA = a["Date"].split("/");
          List<String> dateB = b["Date"].split("/");

          DateTime parsedDateA = DateTime(
              int.parse(dateA[2]), int.parse(dateA[1]), int.parse(dateA[0]));
          DateTime parsedDateB = DateTime(
              int.parse(dateB[2]), int.parse(dateB[1]), int.parse(dateB[0]));

          return parsedDateA.compareTo(parsedDateB);
        });
        isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, "Error fetching rides: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('See Requested Delivery'),
          ),
          backgroundColor: Theme.of(context).cardColor,
          body: requestedDeliveries.isNotEmpty
              ? ListView.builder(
                  itemCount: requestedDeliveries.length,
                  itemBuilder: (context, index) {
                    final delivery = requestedDeliveries[index];
                    return InfoDelivery(
                      delivery: delivery,
                      rideId: shortenUUID(delivery['id']),
                      date: delivery['Date'],
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No request till now!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CustomLoader(),
              ),
            ),
          ),
      ],
    );
  }
}

class InfoDelivery extends StatelessWidget {
  const InfoDelivery({
    super.key,
    required this.date,
    required this.rideId,
    required this.delivery,
  });

  final String date;
  final Map<String, dynamic> delivery;
  final String rideId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Delivery id - $rideId'),
        subtitle: Text('Date - $date'),
        trailing: const Icon(FontAwesomeIcons.arrowRight),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestedRide(delivery: delivery),
            ),
          );
        },
      ),
    );
  }
}
