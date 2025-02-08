import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/theme/theme.dart';

class AddressFilled extends StatefulWidget {
  const AddressFilled({super.key});

  @override
  State<AddressFilled> createState() => _AddressFilledState();
}

class _AddressFilledState extends State<AddressFilled> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pickup Location',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.locationCrosshairs),
              const SizedBox(width: 6),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter pickup address or select on map',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.map, color:theme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Destination',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.locationDot),
              const SizedBox(width: 6),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter destination address or select on map',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.map, color: theme.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
