import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/ride_info_search_ride.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/requested_ride.dart';
import 'package:logistics_express/src/services/map_services/api_services.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import 'package:logistics_express/src/utils/theme.dart';

class AvailableRides extends StatefulWidget {
  const AvailableRides({
    super.key,
    required this.source,
    required this.destination,
  });

  final String source;
  final String destination;

  @override
  State<AvailableRides> createState() => _AvailableRidesState();
}

class _AvailableRidesState extends State<AvailableRides> {
  List<Map<String, dynamic>> availableRides = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllRides();
  }

  // Fetch rides that match source, destination & date within a range
  Future<void> fetchAllRides() async {
    try {
      setState(() => isLoading = true);

      Map<String, double>? sourceCoords =
          await ApiServices().getLatLngFromAddress(widget.source);
      Map<String, double>? destCoords =
          await ApiServices().getLatLngFromAddress(widget.destination);

      double sourceLat = sourceCoords!['lat']!;
      double sourceLng = sourceCoords['lng']!;
      double destLat = destCoords!['lat']!;
      double destLng = destCoords['lng']!;

      // Fetch only upcoming rides from Firestore (Filter by date)
      DateTime today = DateTime.now();
      DateTime todayOnly = DateTime(today.year, today.month, today.day);

      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collectionGroup("rides").get();

      List<Map<String, dynamic>> matchingRides = [];
      for (var doc in snapshot.docs) {
        Map<String, dynamic> ride = doc.data() as Map<String, dynamic>;

        if (parseDate(ride["StartDate"]).isBefore(todayOnly)) continue;

        List<dynamic>? route = ride['Route'];
        if (route == null || route.isEmpty) continue;
        bool sourceMatch = false, destMatch = false;

        for (var city in route) {
          double cityLat = city.latitude;
          double cityLng = city.longitude;

          if (!sourceMatch &&
              isWithinDistance(sourceLat, sourceLng, cityLat, cityLng, 20)) {
            sourceMatch = true;
          }
          if (!destMatch &&
              isWithinDistance(destLat, destLng, cityLat, cityLng, 20)) {
            destMatch = true;
          }
          if (sourceMatch && destMatch) break;
        }

        if (sourceMatch && destMatch) {
          matchingRides.add(ride);
        }
      }

      // Sort rides by StartDate (ascending order)
      matchingRides.sort((a, b) {
        DateTime dateA = parseDate(a["StartDate"]);
        DateTime dateB = parseDate(b["StartDate"]);
        return dateA.compareTo(dateB);
      });

      setState(() {
        availableRides = matchingRides;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      showErrorSnackBar(context, "Error fetching rides: $e");
      setState(() => isLoading = false);
    }
  }

  // Parses date string (DD/MM/YYYY)
  DateTime parseDate(String dateStr) {
    List<String> parts = dateStr.split("/");
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  // Check if two locations are within maxDistance (in km)
  bool isWithinDistance(double lat1, double lng1, double lat2, double lng2,
      double maxDistanceKm) {
    return true; // Remove when needed
    double distance = Geolocator.distanceBetween(lat1, lng1, lat2, lng2) / 1000;
    return distance <= maxDistanceKm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Rides')),
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: kColorScheme.secondaryContainer.withOpacity(1),
              border: Border.all(color: kColorScheme.primary),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInfoRow(
                        icon: FontAwesomeIcons.locationDot,
                        text: "From : ${widget.source}",
                      ),
                      CustomInfoRow(
                        icon: FontAwesomeIcons.mapPin,
                        text: "To : ${widget.destination}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: const Center(
                        child: CustomLoader(),
                      ),
                    ),
                  )
                : availableRides.isNotEmpty
                    ? ListView.builder(
                        itemCount: availableRides.length,
                        itemBuilder: (context, index) {
                          final ride = availableRides[index];
                          return InfoRides(
                            rideId: shortenUUID(ride['id']),
                            date: ride['StartDate'],
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'No Available Rides, You can make a request for a ride',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class InfoRides extends StatelessWidget {
  const InfoRides({
    super.key,
    required this.date,
    required this.rideId,
  });

  final String date;
  final String rideId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Ride id - $rideId'),
        subtitle: Text('Date - $date'),
        trailing: const Icon(FontAwesomeIcons.arrowRight),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RideInformationSR(
                rideId: rideId,
                rideDate: date,
              ),
            ),
          );
        },
      ),
    );
  }
}
