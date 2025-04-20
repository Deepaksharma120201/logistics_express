import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';

class RideInformationScreen extends StatefulWidget {
  final Map<String, dynamic> ride;

  const RideInformationScreen({
    super.key,
    required this.ride,
  });

  @override
  State<RideInformationScreen> createState() => _RideInformationScreenState();
}

class _RideInformationScreenState extends State<RideInformationScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Ride Details"),
          ),
          backgroundColor: theme.cardColor,
          body: Column(
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
                        title: "Ride Details",
                      ),
                      CustomInfoRow(
                        icon: FontAwesomeIcons.locationDot,
                        text: "From: ${widget.ride['Source']}",
                      ),
                      CustomInfoRow(
                        icon: FontAwesomeIcons.mapPin,
                        text: "To: ${widget.ride['Destination']}",
                      ),
                      CustomInfoRow(
                        icon: FontAwesomeIcons.calendarDays,
                        text: "Start Date: ${widget.ride['Date']}",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Track Ride'),
                ),
              )
            ],
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
