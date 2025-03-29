import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/agent_dashboard_screen.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';
import 'package:logistics_express/src/services/map_services/api_services.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import '../../../../custom_widgets/date_picker.dart';
import '../../../../utils/new_text_field.dart';
import '../../../../utils/validators.dart';

class UpdateRide extends ConsumerStatefulWidget {
  const UpdateRide({
    super.key,
    required this.ride,
  });

  final Map<String, dynamic> ride;
  @override
  ConsumerState<UpdateRide> createState() => _UpdateRideState();
}

class _UpdateRideState extends ConsumerState<UpdateRide> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _startDateController.text = widget.ride['StartDate'];
    _endDateController.text = widget.ride['EndDate'];
  }

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);

    Future<void> updateRide() async {
      setState(() => isLoading = true);
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String source = authController.sourceAddressController.text.trim();
        String destination =
            authController.destinationAddressController.text.trim();
        List<GeoPoint> route = [];
        // route = await ApiServices().getIntermediateCities(source, destination);

        await FirebaseFirestore.instance
            .collection("published-rides")
            .doc(user!.uid)
            .collection("rides") // Sub-collection for deliveries
            .doc(widget.ride['id'])
            .update({
          'Source': authController.sourceAddressController.text.trim(),
          "Destination":
              authController.destinationAddressController.text.trim(),
          "Route": route,
          "StartDate": _startDateController.text,
          'EndDate': _endDateController.text,
        });

        if (!context.mounted) return;
        showSuccessSnackBar(context, "Ride updated successfully!");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgentHomeScreen(),
          ),
        );
      } catch (err) {
        if (!context.mounted) return;
        showErrorSnackBar(context, "Error Updating ride: $err");
      } finally {
        setState(() => isLoading = false);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Ride - ID: ${shortenUUID(widget.ride['id'])}'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: AbsorbPointer(
        absorbing: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressFilled(
                    source: widget.ride['Source'],
                    destination: widget.ride['Destination'],
                    check: true,
                  ),
                  const SizedBox(height: 30),
                  NewTextField(
                    hintText: "DD/MM/YYYY",
                    label: 'Start Date',
                    keyboardType: TextInputType.number,
                    controller: _startDateController,
                    readOnly: true,
                    onTap: () async {
                      String selectedDate =
                          await DatePicker.pickDate(context, ref);
                      setState(() {
                        _startDateController.text = selectedDate;
                      });
                    },
                    suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                    validator: (val) => Validators.validateDate(val!),
                  ),
                  const SizedBox(height: 10),
                  NewTextField(
                    hintText: "DD/MM/YYYY",
                    label: 'End Date',
                    controller: _endDateController,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    onTap: () async {
                      String selectedDate =
                          await DatePicker.pickDate(context, ref);
                      setState(() {
                        _endDateController.text = selectedDate;
                      });
                    },
                    suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                    validator: (val) => Validators.validateEndDate(
                        val!, _startDateController.text),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          updateRide();
                        } else {
                          showErrorSnackBar(
                            context,
                            "Please fill all fields!",
                          );
                        }
                      },
                      child: const Text('Update Ride'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
