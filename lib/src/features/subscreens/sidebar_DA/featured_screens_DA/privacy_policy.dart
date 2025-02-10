import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        // backgroundColor: Colors.purple,
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Privacy Policy for Logistics Express",
              style: TextStyle(
                fontSize: 20.0, // Size for heading
                fontWeight: FontWeight.bold, // Makes the text bold
              ),
            ),
            SizedBox(height: 16.0),

            // Introduction
            Text(
              "At Logistics Express, we value your privacy. This policy explains how we collect, use, and protect your information.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // What We Collect Section
            buildSectionTitle("What We Collect"),
            buildBulletPoint(
                "Personal Information: Name, contact details, delivery addresses, and payment details."),
            buildBulletPoint(
                "Location Data: To track deliveries and improve services."),
            buildBulletPoint(
                "App Usage Data: Information about how you interact with our app."),

            // How We Use Your Data Section
            SizedBox(height: 16.0),
            buildSectionTitle("How We Use Your Data"),
            buildBulletPoint("To process deliveries and provide services."),
            buildBulletPoint("To communicate with you about your orders."),
            buildBulletPoint("To improve app functionality and security."),

            // Who We Share With Section
            SizedBox(height: 16.0),
            buildSectionTitle("Who We Share With"),
            buildBulletPoint("Delivery partners for order fulfillment."),
            buildBulletPoint(
                "Service providers for payment processing and app maintenance."),
            buildBulletPoint("Legal authorities when required by law."),

            // Your Choices Section
            SizedBox(height: 16.0),
            buildSectionTitle("Your Choices"),
            buildBulletPoint("Update or delete your account information."),
            buildBulletPoint(
                "Opt-out of location tracking and marketing messages."),

            // Data Security Section
            SizedBox(height: 16.0),
            buildSectionTitle("Data Security"),
            Text(
              "We take measures to protect your data, but no system is entirely secure.",
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022",
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
