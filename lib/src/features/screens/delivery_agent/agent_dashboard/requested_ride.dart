import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

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
                  color: colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(
                            "Delivery Details", textTheme, colorScheme),
                        _buildInfoRow(
                            FontAwesomeIcons.locationDot,
                            "From: ${widget.delivery['Source']}",
                            textTheme,
                            colorScheme),
                        _buildInfoRow(
                            FontAwesomeIcons.mapPin,
                            "To: ${widget.delivery['Destination']}",
                            textTheme,
                            colorScheme),
                        _buildInfoRow(
                            FontAwesomeIcons.calendarDays,
                            "Date: ${widget.delivery['Date']}",
                            textTheme,
                            colorScheme),
                        const Divider(thickness: 1, height: 20),
                        _buildSectionTitle(
                            "Customer Info", textTheme, colorScheme),
                        _buildInfoRow(
                            FontAwesomeIcons.user,
                            "Name: ${widget.delivery['Name']}",
                            textTheme,
                            colorScheme),
                        _buildInfoRow(
                            FontAwesomeIcons.phone,
                            "Phone: ${widget.delivery['Phone']}",
                            textTheme,
                            colorScheme),
                        const Divider(thickness: 1, height: 20),
                        _buildSectionTitle(
                            "Cargo Information", textTheme, colorScheme),
                        _buildInfoRow(
                            FontAwesomeIcons.box,
                            "Type: ${widget.delivery['ItemType']}",
                            textTheme,
                            colorScheme),
                        _buildInfoRow(
                            FontAwesomeIcons.weightHanging,
                            "Weight: ${widget.delivery['Weight']} kg",
                            textTheme,
                            colorScheme),
                        _buildInfoRow(
                            FontAwesomeIcons.cube,
                            "Volume: ${widget.delivery['Volume']} cm³",
                            textTheme,
                            colorScheme),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Accept Delivery'),
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

  Widget _buildSectionTitle(
      String title, TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: textTheme.headlineMedium?.copyWith(color: colorScheme.primary),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, TextTheme textTheme,
      ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // Increased padding
      child: Row(
        children: [
          Icon(icon, size: 22, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
