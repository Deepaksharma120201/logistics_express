import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/subscreens/address_field/auto_search.dart';
import 'package:logistics_express/src/utils/validators.dart';
import 'package:logistics_express/src/services/authentication/auth_controller.dart';

class AddressFilled extends ConsumerStatefulWidget {
  const AddressFilled({
    super.key,
    this.source,
    this.destination,
    this.check = false,
  });

  final String? source;
  final String? destination;
  final bool check;

  @override
  ConsumerState<AddressFilled> createState() => _AddressFilledState();
}

class _AddressFilledState extends ConsumerState<AddressFilled> {
  void _selectAddress(TextEditingController controller) async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const AutoSearch(),
      ),
    );
    if (selectedAddress != null) {
      setState(() {
        controller.text = selectedAddress;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final authController = ref.read(authControllerProvider);

    if (widget.check) {
      authController.sourceAddressController.text = widget.source!;
      authController.destinationAddressController.text = widget.destination!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pickup Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 3),
        AddressTextField(
          controller: authController.sourceAddressController,
          hintText: 'Enter pickup address or select on map',
          onTap: () => _selectAddress(authController.sourceAddressController),
        ),
        const SizedBox(height: 20),
        Text(
          'Destination',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 3),
        AddressTextField(
          controller: authController.destinationAddressController,
          hintText: 'Enter destination address or select on map',
          onTap: () =>
              _selectAddress(authController.destinationAddressController),
        ),
      ],
    );
  }
}

class AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onTap;

  const AddressTextField({
    required this.controller,
    required this.hintText,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.locationCrosshairs),
          const SizedBox(width: 6),
          Expanded(
            child: TextFormField(
              validator: (val) => Validators.commonValidator(val!),
              controller: controller,
              readOnly: true, //do change here when required only write false
              onTap: onTap, //do change here when required only write onTap
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
