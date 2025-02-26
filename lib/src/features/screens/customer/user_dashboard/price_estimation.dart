import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import 'package:logistics_express/src/utils/new_text_field.dart';
import 'package:logistics_express/src/utils/validators.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';
import 'package:logistics_express/src/services/map_services/api_services.dart';
import '../../../../custom_widgets/custom_dropdown.dart';

class PriceEstimation extends ConsumerStatefulWidget {
  const PriceEstimation({super.key});

  @override
  ConsumerState<PriceEstimation> createState() => _PriceEstimationState();
}

class _PriceEstimationState extends ConsumerState<PriceEstimation> {
  bool isLoading = false;
  String? _selectedType;

  Future<double> getDistance() async {
    try {
      return 165; //remove this when necessary
      final response = await ApiServices().getDistanceFromPlaces(
        ref.read(authControllerProvider).sourceAddressController.text.trim(),
        ref
            .read(authControllerProvider)
            .destinationAddressController
            .text
            .trim(),
      );

      if (response.rows != null &&
          response.rows!.isNotEmpty &&
          response.rows![0].elements != null &&
          response.rows![0].elements!.isNotEmpty) {
        String? distanceText = response.rows![0].elements![0].distance?.text;
        if (distanceText != null) {
          return double.parse(distanceText.split(" ")[0]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        final localContext = context;
        showErrorSnackBar(localContext, "Error getting distance: $e");
      }
    }
    return 0.0;
  }

  void priceEstimate() async {
    final authController = ref.read(authControllerProvider);

    setState(() => isLoading = true);
    try {
      double basePrice = 50.0;
      double weight = double.parse(authController.weightController.text.trim());
      double volume = double.parse(authController.volumeController.text.trim());
      double distance = await getDistance();
      double weightRate = 10.0;
      double volumeRate = 10.0;
      double distanceRate = 2.0;

      double price = basePrice +
          (weight * weightRate) +
          (volume * volumeRate) +
          (distance * distanceRate);

      authController.clearAll();
      if (context.mounted) {
        final localContext = context;
        showModalBottomSheet(
          context: localContext,
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Estimated Price: ₹ ${price.toStringAsFixed(2)}/-',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        final localContext = context;
        showErrorSnackBar(localContext, "Error estimating price: $e");
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(title: Text('Price Estimation')),
            backgroundColor: Theme.of(context).cardColor,
            body: AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AddressFilled(),
                        const SizedBox(height: 20),
                        NewTextField(
                          validator: (val) => Validators.quantityValidator(val),
                          label: 'Weight',
                          controller: ref
                              .watch(authControllerProvider)
                              .weightController,
                          hintText: 'Enter weight in Kg',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        NewTextField(
                          validator: (val) => Validators.quantityValidator(val),
                          label: 'Volume',
                          controller: ref
                              .watch(authControllerProvider)
                              .volumeController,
                          hintText: 'Enter volume in cm\u00B3',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        CustomDropdown(
                          label: "Item Type",
                          items: [
                            'Furniture',
                            'Electronics',
                            'Clothes & Accessories',
                            'Glass & Fragile Items',
                            'Food & Medicine'
                          ],
                          value: _selectedType,
                          onChanged: (value) =>
                              setState(() => _selectedType = value),
                          validator: (val) => Validators.commonValidator(val),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              priceEstimate();
                            } else {
                              showErrorSnackBar(
                                context,
                                "Please fill all fields!",
                              );
                            }
                          },
                          child: const Text('Estimate Price'),
                        ),
                      ],
                    ),
                  ),
                ),
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
