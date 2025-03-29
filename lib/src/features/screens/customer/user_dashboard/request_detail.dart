import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_dialog.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/user_dashboard_screen.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';

class RequestDetail extends StatefulWidget {
  final Map<String, dynamic> ride;

  const RequestDetail({
    super.key,
    required this.ride,
  });

  @override
  State<RequestDetail> createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  bool isLoading = false;

  Future<void> _cancelRequest() async {
    setState(() => isLoading = true);

    try {
      final User? user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('requested-deliveries')
          .doc(user!.uid)
          .collection('deliveries')
          .doc(widget.ride['id'])
          .delete();
      if (!mounted) return;
      showSuccessSnackBar(context, 'Request cancelled successfully!');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserHomeScreen(),
        ),
      );
    } catch (e) {
      showErrorSnackBar(context, 'Error cancelling request: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Request Detail"),
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
                          title: "Requested Ride Details",
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
                          text: "Date: ${widget.ride['Date']}",
                        ),
                        const Divider(thickness: 1, height: 20),
                        CustomSectionTitle(
                          title: "Customer Info",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.user,
                          text: "Name: ${widget.ride['Name']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.phone,
                          text: "Phone: ${widget.ride['Phone']}",
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (widget.ride['IsPending'])
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: 'Are you sure?',
                              message:
                                  'Do you want to cancel the current request?',
                              onConfirm: () => _cancelRequest(),
                            );
                          },
                        );
                      },
                      child: const Text('Cancel request'),
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
