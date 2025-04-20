import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';

class PaymentDetail extends StatefulWidget {
  final Map<String, dynamic> ride;

  const PaymentDetail({
    super.key,
    required this.ride,
  });

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Payment Details"),
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
                        CustomInfoRow(
                          icon: FontAwesomeIcons.calendarDays,
                          text: "End Date: ${widget.ride['EndDate']}",
                        ),
                        const Divider(thickness: 1, height: 20),
                        CustomSectionTitle(
                          title: "Delivery Agent Details",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.user,
                          text: "Name: ${widget.ride['AgentName']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.phone,
                          text: "Phone: ${widget.ride['AgentPhone']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.truck,
                          text: "Vehicle Type: ${widget.ride['VehicleType']}",
                        ),
                        const Divider(thickness: 1, height: 20),
                        CustomSectionTitle(
                          title: "Cargo Information",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.box,
                          text: "Type: ${widget.ride['ItemType']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.weightHanging,
                          text: "Weight: ${widget.ride['Weight']} kg",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.cube,
                          text: "Volume: ${widget.ride['Volume']} cm³",
                        ),
                        const Divider(thickness: 1, height: 20),
                        CustomSectionTitle(
                          title: "Payment Information",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.indianRupeeSign,
                          text: "Amount: ${widget.ride['Amount']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.circleCheck,
                          text: "Status: Completed",
                        ),
                      ],
                    ),
                  ),
                )
              ],
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
