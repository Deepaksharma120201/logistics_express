import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/privacy_policy.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/Term_Condition.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/featured_screens/about_us.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('About'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          customListTile(
            context,
            'Privacy Policy',
            PrivacyPolicy(),
          ),
          SizedBox(height: 16), // Add spacing between the items
          customListTile(
            context,
            'Terms and Conditions',
            TermsConditions(),
          ),
          SizedBox(height: 16), // Add spacing between the items
          customListTile(
            context,
            'About Us',
            AboutUs(),
          ),
        ],
      ),
    );
  }

  ListTile customListTile(BuildContext context, String text, Widget route) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => route),
        );
      },
      tileColor: const Color(0xFFEDE7F6), // Specified card color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black, // Text color for contrast
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
