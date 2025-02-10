import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';

class UpdateRide extends StatelessWidget {
  const UpdateRide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Ride'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddressFilled(),
            const SizedBox(height: 30),
            _buildLabel('Start Date'),
            _buildContainer(),
            const SizedBox(height: 30),
            _buildLabel('End Date'),
            _buildContainer(),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Update Ride'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      width: 380,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: const Text(''),
    );
  }
}
