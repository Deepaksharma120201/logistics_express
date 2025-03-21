import 'package:flutter/material.dart';

class ContactSupport extends StatelessWidget {
  const ContactSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Contact Support'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomCard(
                title: 'Contact us on: ',
                subtitle: '+91-9306460815 /\n+91-7056921547'),
            CustomCard(
                title: 'Mail us on :', subtitle: '523110009@nittkkr.ac.in'),
            // Card(
            //   margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
            //   child: ListTile(title: Text('Click for live chatbot')),
            // ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
