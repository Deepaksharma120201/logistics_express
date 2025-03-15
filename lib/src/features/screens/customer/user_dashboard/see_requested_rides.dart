import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/request_detail.dart';

class SeeRequestedRides extends StatefulWidget{
  const SeeRequestedRides ({super.key});
  @override
  State<SeeRequestedRides> createState(){
    return SeeRequestedRidesState();
  }
}

class SeeRequestedRidesState extends State<SeeRequestedRides> {

  int selectedTabIndex=0;
  final List<Map<String, String>> pendingRequest = [
    {'destination': 'Mumbai', 'requestDate': '10/12/2024'},
    {'destination': 'Delhi', 'requestDate': '11/12/2024'},
  ];

  final List<Map<String, String>> activeRequest = [
    {'destination': 'Jaipur', 'requestDate': '05/12/2024'},
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('See Requested Rides'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body:
        selectedTabIndex==0
        ?RequestList(request: pendingRequest,
        selectedTabIndex: selectedTabIndex,)
        :RequestList(request: activeRequest,
        selectedTabIndex: selectedTabIndex,),
      bottomNavigationBar: NavigationBar(
          indicatorColor: Theme.of(context).primaryColor,
          destinations: const [
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.listCheck),
              label: 'Pending',
            ),
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.barsProgress),
              label: 'Active',
            ),
          ],
          selectedIndex: selectedTabIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedTabIndex = index;
            });
          },
      ),
    );
  }
}

class RequestList extends StatelessWidget{
  final List<Map<String,String>> request;
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
        itemBuilder: (context,index){
        final type= request[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('Destination - ${type['destination']}'),
            subtitle: Text('Request date - ${type['requestDate']}'),
            trailing: const Icon(FontAwesomeIcons.arrowRight),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RequestDetail(
                    destination: type['destination'] ?? '',
                    requestDate: type['requestDate'] ?? '',
                    isPending: selectedTabIndex == 0,
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