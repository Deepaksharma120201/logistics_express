import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/date_picker.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/custom_widgets/custom_dropdown.dart';
import '../../../../custom_widgets/custom_loader.dart';
import '../../../../models/publish_ride_model.dart';
import '../../../../services/authentication/auth_controller.dart';
import '../../../../services/user_services.dart';
import '../../../../utils/firebase_exceptions.dart';
import '../../../../utils/new_text_field.dart';
import '../../../../utils/validators.dart';

class PublishRide extends ConsumerStatefulWidget {
  const PublishRide({super.key});

  @override
  ConsumerState<PublishRide> createState() => _PublishRideState();
}

class _PublishRideState extends ConsumerState<PublishRide> {
  String? _dropdownValue;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authController = ref.read(authControllerProvider);

    Future<void> publishRide() async {
      setState(() => _isLoading = true);
      try {
        PublishRideModel ride = PublishRideModel(
          name: authController.nameController.text.trim(),
          phoneNo: authController.phoneController.text.trim(),
          startDate: authController.startDateController.text.trim(),
          endDate: authController.endDateController.text.trim(),
          vehicleType: _dropdownValue!,
          source: authController.sourceAddressController.text.trim(),
          destination: authController.destinationAddressController.text.trim(),
        );

        final userServices = UserServices();
        await userServices.publishRide(ride);
        authController.clearAll();

        if (context.mounted) {
          showSuccessSnackBar(context, "Ride published successfully!");
          Navigator.of(context).pop();
        }
      } catch (error) {
        if (context.mounted) {
          showErrorSnackBar(context, 'Error: ${error.toString()}');
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }

    return Stack(children: [
      GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Publish Ride'),
          ),
          backgroundColor: Theme.of(context).cardColor,
          body: AbsorbPointer(
            absorbing: _isLoading,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AddressFilled(),
                      const SizedBox(height: 20),
                      NewTextField(
                        hintText: "DD/MM/YYYY",
                        label: 'Start Date',
                        controller: authController.startDateController,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        onTap: () async {
                          String selectedDate =
                              await DatePicker.pickDate(context);
                          setState(() {
                            authController.startDateController.text =
                                selectedDate;
                          });
                        },
                        suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                        validator: (val) => Validators.validateDate(val),
                      ),
                      const SizedBox(height: 10),
                      NewTextField(
                        hintText: "DD/MM/YYYY",
                        label: 'End Date',
                        controller: authController.endDateController,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        onTap: () async {
                          String selectedDate =
                              await DatePicker.pickDate(context);
                          setState(() {
                            authController.endDateController.text =
                                selectedDate;
                          });
                        },
                        suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                        validator: (val) => Validators.validateEndDate(
                            val, authController.startDateController.text),
                      ),
                      const SizedBox(height: 10),
                      NewTextField(
                        label: 'Name',
                        controller: authController.nameController,
                        hintText: 'Enter name',
                        validator: (val) => Validators.validateName(val),
                      ),
                      SizedBox(height: 10),
                      NewTextField(
                        controller: authController.phoneController,
                        label: 'Phone Number',
                        hintText: 'Enter phone number',
                        validator: (val) => Validators.validatePhone(val),
                      ),
                      SizedBox(height: 10),
                      CustomDropdown(
                        label: 'Vehicle Type',
                        items: [
                          'Pickup Truck',
                          'Mini Truck',
                          'Small Cargo Van',
                          'Rigid Truck'
                        ],
                        value: _dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdownValue = newValue;
                          });
                        },
                        validator: (val) => Validators.commonValidator(val),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              publishRide();
                            } else {
                              showErrorSnackBar(
                                context,
                                'Please fill all required fields.',
                              );
                            }
                          },
                          child: Text('Publish Ride'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      if (_isLoading)
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: const Center(
              child: CustomLoader(),
            ),
          ),
        ),
    ]);
  }
}
