import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_dialog.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';
import 'package:logistics_express/src/utils/theme.dart';

class RideInformationSR extends StatelessWidget {
  final Map<String, dynamic> ride;

  const RideInformationSR({
    super.key,
    required this.ride,
  });

  Future<void> sendRequest() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ride Details"),
      ),
      backgroundColor: theme.cardColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: theme.colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSectionTitle(
                      title: "Current Ride Details",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.locationDot,
                      text: "From: ${ride['Source']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.mapPin,
                      text: "To: ${ride['Destination']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.calendarDays,
                      text: "Start Date: ${ride['StartDate']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.calendarDays,
                      text: "End Date: ${ride['EndDate']}",
                    ),
                    const Divider(thickness: 1, height: 20),
                    CustomSectionTitle(
                      title: "Delivery Agent Details",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.user,
                      text: "Name: ${ride['Name']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.phone,
                      text: "Phone: ${ride['Phone']}",
                    ),
                    CustomInfoRow(
                      icon: FontAwesomeIcons.truck,
                      text: "Vehicle Type: ${ride['VehicleType']}",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: 'Are you sure?',
                        message: 'Do you want to send the request?',
                        onConfirm: () => sendRequest(),
                      );
                    },
                  );
                },
                child: const Text('Send request'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
