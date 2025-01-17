import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/driving_licence.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/profile_info.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/vehicle_rc.dart';
import 'package:logistics_express/src/features/utils/delivery_agent_faq.dart';

class DetailsFillup extends StatelessWidget {
  const DetailsFillup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Complete Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => DeliveryAgentFaq()),
              );
            },
            icon: const Icon(FontAwesomeIcons.circleQuestion),
          ),
        ],
      ),
      body: GridView(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: [
          containerButton(context, 'Profile Info', ProfileInfo()),
          containerButton(context, 'Driving Licence', DrivingLicence()),
          containerButton(context, 'Vehicle RC', VehicleRc()),
        ],
      ),
    );
  }

  InkWell containerButton(BuildContext context, String text, Widget route) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => route),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.55),
              Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              FontAwesomeIcons.arrowRight,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
