import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/price_estimation.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/search_ride.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/slide_drawer.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() {
    return _UserHomeScreenState();
  }
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline),
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
          _containerButton(context, 'Search Ride', SearchRide()),
          _containerButton(context, 'Make Request', SearchRide()),
          _containerButton(context, 'See Requested Rides', SearchRide()),
          _containerButton(context, 'Track Delivery', SearchRide()),
          _containerButton(context, 'View Payment History', SearchRide()),
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