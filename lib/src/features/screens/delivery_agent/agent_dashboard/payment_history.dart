import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/payment_detail.dart';

import 'package:logistics_express/src/utils/firebase_exceptions.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});
  @override
  State<PaymentHistory> createState() {
    return PaymentHistoryState();
  }
}

class PaymentHistoryState extends State<PaymentHistory> {
  bool isLoading = true;
  List<Map<String, dynamic>> rides = [];

  @override
  void initState() {
    super.initState();
    fetchAllRides();
  }

  Future<void> fetchAllRides() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    try {
      QuerySnapshot rideDocs = await fireStore
          .collection("published-rides")
          .doc(user!.uid)
          .collection("specific-rides")
          .get();

      for (var doc in rideDocs.docs) {
        Map<String, dynamic> rideData = doc.data() as Map<String, dynamic>;
        rides.add(rideData);
      }

      // Sort all rides
      rides.sort((b, a) {
        DateTime parsedDateA = _parseDate(a["Date"]);
        DateTime parsedDateB = _parseDate(b["Date"]);
        return parsedDateA.compareTo(parsedDateB);
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  DateTime _parseDate(String dateString) {
    List<String> dateParts = dateString.split("/");
    return DateTime(
      int.parse(dateParts[2]), // Year
      int.parse(dateParts[1]), // Month
      int.parse(dateParts[0]), // Day
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isListEmpty = rides.isEmpty;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Payment History'),
          ),
          backgroundColor: Theme.of(context).cardColor,
          body: isListEmpty
              ? Center(
                  child: Text(
                    "No delivery payments received yet.",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : RequestList(
                  request: rides,
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
        final ride = request[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ride ID: ${shortenUUID(ride['id'])}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text('From: ${ride['Source']}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text('To: ${ride['Destination']}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text('Date: ${ride['Date']}',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            trailing: const Icon(FontAwesomeIcons.arrowRight),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentDetail(
                    ride: ride,
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
