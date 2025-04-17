import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<Map<String, dynamic>> normalDeliveries = [];
  List<Map<String, dynamic>> specificDeliveries = [];

  int selectedTabIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllDeliveries();
  }

  Future<void> fetchAllDeliveries() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

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
          normalDeliveries.add(rideData);
        }
      }

      QuerySnapshot rideDocsSpecific = await fireStore
          .collection("published-rides")
          .doc(user!.uid)
          .collection("specific-rides")
          .get();

      for (var doc in rideDocsSpecific.docs) {
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
          specificDeliveries.add(rideData);
        }
      }

      setState(() {
        normalDeliveries.sort((a, b) {
          List<String> dateA = a["Date"].split("/");
          List<String> dateB = b["Date"].split("/");

          DateTime parsedDateA = DateTime(
              int.parse(dateA[2]), int.parse(dateA[1]), int.parse(dateA[0]));
          DateTime parsedDateB = DateTime(
              int.parse(dateB[2]), int.parse(dateB[1]), int.parse(dateB[0]));

          return parsedDateA.compareTo(parsedDateB);
        });

        specificDeliveries.sort((a, b) {
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
    final bool isListEmpty = selectedTabIndex == 0
        ? specificDeliveries.isEmpty
        : normalDeliveries.isEmpty;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('See Requested Delivery'),
          ),
          backgroundColor: Theme.of(context).cardColor,
          body: isListEmpty
              ? Center(
                  child: Text(
                    "No request till now!",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : RequestList(
                  request: selectedTabIndex == 0
                      ? specificDeliveries
                      : normalDeliveries,
                ),
          bottomNavigationBar: NavigationBar(
            indicatorColor: Theme.of(context).primaryColor,
            destinations: const [
              NavigationDestination(
                icon: Icon(FontAwesomeIcons.bullseye),
                label: 'Specific',
              ),
              NavigationDestination(
                icon: Icon(FontAwesomeIcons.user),
                label: 'Normal',
              ),
            ],
            selectedIndex: selectedTabIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedTabIndex = index;
              });
            },
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

class RequestList extends StatelessWidget {
  final List<Map<String, dynamic>> request;

  const RequestList({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: request.length,
      itemBuilder: (context, index) {
        final type = request[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('Delivery id - ${shortenUUID(type['id'])}'),
            subtitle: Text('Request Date - ${type['Date']}'),
            trailing: const Icon(FontAwesomeIcons.arrowRight),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestedRide(
                    delivery: request[index],
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
