import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Terms and Conditions",
              style: TextStyle(
                fontSize: 20.0, // Size for heading
                fontWeight: FontWeight.bold, // Makes the text bold
              ),
            ),

            SizedBox(height: 16.0),

            // What We Collect Section
            buildSectionTitle("Service Scope:"),
            buildBulletPoint(
                "Logistics Express provides logistics and delivery services as per the agreed schedule and locations."),
            buildSectionTitle("User Responsibilities:"),
            buildBulletPoint(
                "Users must provide accurate information, including delivery addresses, contact details, and package details. Users are responsible for ensuring the legality and proper packaging of their items."),
            buildSectionTitle("Prohibited Items:"),
            buildBulletPoint(
                "Restricted items include hazardous materials, illegal goods, perishable items, and any other items as stated by law."),
            buildSectionTitle("Liability:"),
            buildBulletPoint(
                "Logistics Express is not liable for damages or losses due to incorrect information, natural disasters, or any unforeseen events beyond our control."),
            buildSectionTitle("Delivery Times:"),
            buildBulletPoint(
                "Estimated delivery times are not guaranteed and may vary due to unforeseen circumstances."),
            buildSectionTitle("Fees:"),
            buildBulletPoint(
                "All charges, including taxes, must be paid as per the agreed terms. Late payments may incur additional fees."),
            buildSectionTitle("Cancellations & Refunds:"),
            buildBulletPoint(
                "Cancellation policies and eligibility for refunds depend on the stage of processing and type of service selected."),
            buildSectionTitle("Data Protection:"),
            buildBulletPoint(
                "User information is handled as per our Privacy Policy and is not shared with third parties without consent."),
            buildSectionTitle("Disputes:"),
            buildBulletPoint(
                "Any disputes must be reported within 7 days of the delivery date. Unresolved issues are subject to arbitration."),
            buildSectionTitle("Changes to Terms:"),
            buildBulletPoint(
                "Logistics Express reserves the right to amend these terms at any time."),
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
