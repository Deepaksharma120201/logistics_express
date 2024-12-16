import 'package:flutter/material.dart';

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
          '  Pickup Location',
          style: TextStyle(
            color: Color.fromARGB(255, 162, 126, 193),
          ),
        ),
        Card(
          color: Color.fromARGB(200, 184, 176, 191),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Row(
              children: [
                Icon(Icons.my_location_rounded),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter pickup address or select on map',
                      hintStyle: const TextStyle(fontSize: 13),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.map_rounded, color: Colors.purple),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '  Destination',
          style: TextStyle(
            color: Color.fromARGB(255, 162, 126, 193),
          ),
        ),
        Card(
          elevation: 2,
          color: Color.fromARGB(255, 184, 176, 191),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter destination address or select on map',
                      hintStyle: const TextStyle(fontSize: 13),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.map_rounded, color: Colors.purple),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
