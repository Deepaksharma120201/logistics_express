import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/custom_widgets/custom_loader.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/request_detail.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';

class AllRequets extends StatefulWidget {
  const AllRequets({super.key});
  @override
  State<AllRequets> createState() {
    return AllRequetsState();
  }
}

class AllRequetsState extends State<AllRequets> {
  int selectedTabIndex = 0;
  bool isLoading = true;

  List<Map<String, dynamic>> pendingRequest = [];
  List<Map<String, dynamic>> activeRequest = [];

  @override
  void initState() {
    super.initState();
    fetchAllRides();
  }

  Future<void> fetchAllRides() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    List<Map<String, dynamic>> rides = [];

    try {
      QuerySnapshot rideDocs = await fireStore
          .collection("requested-deliveries")
          .doc(user!.uid)
          .collection("deliveries") // Sub-collection for deliveries
          .get();

      for (var doc in rideDocs.docs) {
        Map<String, dynamic> rideData = doc.data() as Map<String, dynamic>;
        rides.add(rideData);
      }

      // Sort all rides
      rides.sort((b, a) {
        DateTime parsedDateA = _parseDate(a["Date"]);
        DateTime parsedDateB = _parseDate(b["Date"]);
        return parsedDateA.compareTo(parsedDateB);
      });

      setState(() {
        pendingRequest =
            rides.where((ride) => ride["IsPending"] == true).toList();
        activeRequest =
            rides.where((ride) => ride["IsPending"] == false).toList();
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      showErrorSnackBar(context, "Error fetching rides: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  DateTime _parseDate(String dateString) {
    List<String> dateParts = dateString.split("/");
    return DateTime(
      int.parse(dateParts[2]), // Year
      int.parse(dateParts[1]), // Month
      int.parse(dateParts[0]), // Day
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isListEmpty =
        selectedTabIndex == 0 ? pendingRequest.isEmpty : activeRequest.isEmpty;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('All Requests'),
          ),
          backgroundColor: Theme.of(context).cardColor,
          body: isListEmpty
              ? Center(
                  child: Text(
                    "No requested rides",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : RequestList(
                  request:
                      selectedTabIndex == 0 ? pendingRequest : activeRequest,
                  selectedTabIndex: selectedTabIndex,
                ),
          bottomNavigationBar: NavigationBar(
            indicatorColor: Theme.of(context).primaryColor,
            destinations: const [
              NavigationDestination(
                icon: Icon(FontAwesomeIcons.clock),
                label: 'Pending',
              ),
              NavigationDestination(
                icon: Icon(FontAwesomeIcons.check),
                label: 'Accepted',
              ),
            ],
            selectedIndex: selectedTabIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedTabIndex = index;
              });
            },
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
}

class RequestList extends StatelessWidget {
  final List<Map<String, dynamic>> request;
  final int selectedTabIndex;

  const RequestList({
    super.key,
    required this.request,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: request.length,
      itemBuilder: (context, index) {
        final type = request[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('Ride id - ${shortenUUID(type['id'])}'),
            subtitle: Text('Request Date - ${type['Date']}'),
            trailing: const Icon(FontAwesomeIcons.arrowRight),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestDetail(
                    ride: request[index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
