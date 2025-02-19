import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/price_estimation.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/publish_ride.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/see_requested_delivery.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/track_delivery.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/update_ride.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/payment_history.dart';
import 'package:logistics_express/src/features/utils/delivery_agent_faq.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/subscreens/sidebar_DA/slide_drawer.dart';

class AgentHomeScreen extends StatefulWidget {
  const AgentHomeScreen({super.key});

  @override
  State<AgentHomeScreen> createState() {
    return _AgentHomeScreenState();
  }
}

class _AgentHomeScreenState extends State<AgentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Dashboard'),
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
      drawer: SideDrawer(),
      body: GridView(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.25,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          _containerButton(context, 'Publish Ride', PublishRide()),
          _containerButton(context, 'Update Ride', UpdateRide()),
          _containerButton(
              context, 'See Requested Delivery', SeeRequestedDelivery()),
          _containerButton(context, 'Track Delivery', TrackDelivery()),
          _containerButton(context, 'View Payment History', PaymentHistory()),
          _containerButton(context, 'Price Estimation', PriceEstimation()),
        ],
      ),
    );
  }

  Widget _containerButton(BuildContext context, String text, Widget route) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => route),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.9),
              Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.75),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
