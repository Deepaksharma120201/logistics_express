import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_dialog.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/agent_dashboard_screen.dart';
import 'package:logistics_express/src/services/notification/notify.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import 'package:logistics_express/src/utils/theme.dart';

class RequestedRide extends StatefulWidget {
  final Map<String, dynamic> delivery;

  const RequestedRide({
    super.key,
    required this.delivery,
  });

  @override
  State<RequestedRide> createState() => _RequestedRideState();
}

class _RequestedRideState extends State<RequestedRide> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<void> acceptDelivery() async {
    setState(() => isLoading = true);
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('agents')
          .doc(user!.uid)
          .get();

      QuerySnapshot querySnapshot1 = await fireStore
          .collectionGroup("deliveries")
          .where("id", isEqualTo: widget.delivery['id'])
          .get();

      QuerySnapshot querySnapshot2 = await fireStore
          .collection("published-rides")
          .doc(user.uid)
          .collection('specific-rides')
          .where("id", isEqualTo: widget.delivery['id'])
          .get();

      QuerySnapshot querySnapshot3 = await fireStore
          .collectionGroup('specfic-requests')
          .where("id", isEqualTo: widget.delivery['id'])
          .get();

      if (querySnapshot1.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot1.docs.first.reference;
        await docRef.update({
          'IsPending': false,
          'AgentName': userDoc['Name'],
          'AgentPhone': userDoc['Phone'],
          'UpiId': userDoc['UPI'],
          'Did':userDoc['id'],
        });
      }

      if (querySnapshot2.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot2.docs.first.reference;
        await docRef.update({'IsPending': false});
      }

      if (querySnapshot3.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot3.docs.first.reference;
        await docRef.update({'IsPending': false, 'UpiId': userDoc['UPI']});
      }

      final docSnapshot = await FirebaseFirestore.instance
          .collection('user_auth')
          .doc(widget.delivery['uId'])
          .get();

      if (docSnapshot.exists) {
        final userDoc2 = docSnapshot.data()!;
        final sId = userDoc2['SId'];
        sendNotification(
          sId,
          '${userDoc["Name"]} accepted your delivery request',
          'Delivery Accepted',
        );
      }

      if (mounted) {
        showSuccessSnackBar(context, "Delivery accepted successfully!");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgentHomeScreen(),
          ),
        );
      }
    } catch (error) {
      debugPrint(error.toString());
      if (mounted) {
        showErrorSnackBar(context, error.toString());
      }
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
            title: const Text("Requested Delivery"),
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
                          title: "Delivery Details",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.locationDot,
                          text: "From: ${widget.delivery['Source']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.mapPin,
                          text: "To: ${widget.delivery['Destination']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.calendarDays,
                          text: "Date: ${widget.delivery['Date']}",
                        ),
                        const Divider(thickness: 1, height: 20),
                        CustomSectionTitle(
                          title: "Customer Info",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.user,
                          text: "Name: ${widget.delivery['Name']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.phone,
                          text: "Phone: ${widget.delivery['Phone']}",
                        ),
                        const Divider(thickness: 1, height: 20),
                        CustomSectionTitle(
                          title: "Cargo Information",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.box,
                          text: "Type: ${widget.delivery['ItemType']}",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.weightHanging,
                          text: "Weight: ${widget.delivery['Weight']} kg",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.cube,
                          text: "Volume: ${widget.delivery['Volume']} cm³",
                        ),
                        CustomInfoRow(
                          icon: FontAwesomeIcons.indianRupeeSign,
                          text:
                              "Estimated Price: ${widget.delivery['Amount']} /-",
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
                            message:
                                'Do you want to accept the current delivery?',
                            onConfirm: () => acceptDelivery(),
                          );
                        },
                      );
                    },
                    child: const Text('Accept Delivery'),
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

class CustomSectionTitle extends StatelessWidget {
  final String title;

  const CustomSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: theme.textTheme.headlineMedium
            ?.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}

class CustomInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // Increased padding
      child: Row(
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
