import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import 'package:logistics_express/src/theme/theme.dart';

class PublishRide extends StatefulWidget {
  const PublishRide({super.key});

  @override
  State<PublishRide> createState() => _PublishRideState();
}

class _PublishRideState extends State<PublishRide> {
  String? _dropdownValue='Select Type'; // Nullable type for initial value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publish Ride'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddressFilled(),
            const SizedBox(height: 30),
            Text(
              'Select Vehicle Type',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            CustomContainer(
              child: DropdownButton<String>(
            value: _dropdownValue == 'Select Type' ? null : _dropdownValue,
              hint: const Text('Select Type'),
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
              dropdownColor: theme.primaryColor,
              underline: SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: "Select Type",
                  child: Text('Select Type'),
                ),
                DropdownMenuItem(
                  value: "Pickup Truck",
                  child: Text(
                      'Pickup Trucks (e.g., Tata Ace, Mahindra Bolero Pickup)'),
                ),
                DropdownMenuItem(
                  value: "Mini Truck",
                  child: Text(
                      'Mini Trucks (e.g., Tata Intra, Ashok Leyland Dost)'),
                ),
                DropdownMenuItem(
                  value: "Small Cargo Van",
                  child: Text(
                      'Small Cargo Vans (e.g., Maruti Suzuki Eeco Cargo, Tata Magic Express)'),
                ),
                DropdownMenuItem(
                  value: "Rigid Truck",
                  child: Text(
                      'Rigid Trucks (e.g., Tata 1613, Ashok Leyland 2518)'),
                ),
              ],
              onChanged: (String? selectedValue) {
                setState(() {
                  _dropdownValue = selectedValue;
                });
              },
              icon: Icon(
                FontAwesomeIcons.caretDown,
                color: Colors.deepPurple,
              ),
              iconSize: 32.0,
            ),
      ),

            SizedBox(height: 30,),
            Text(
              'Start Date',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            CustomContainer(
                child: Text('')
            ),
          ],
        ),
      ),
    );
  }
}
class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final List<BoxShadow> boxShadow;

  const CustomContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.color = Colors.white,
    this.borderRadius = 5.0,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.grey,
        offset: Offset(0, 2),
        blurRadius: 5,
        spreadRadius: 2,
      )
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 50,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}