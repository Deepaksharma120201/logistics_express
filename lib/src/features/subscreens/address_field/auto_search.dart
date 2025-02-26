import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logistics_express/src/utils/firebase_exceptions.dart';
import 'package:logistics_express/src/services/map_services/api_services.dart';
import 'package:logistics_express/src/services/map_services/get_places.dart';
import 'package:logistics_express/src/services/map_services/location_permission.dart';
import 'package:logistics_express/src/features/subscreens/address_field/map_screen.dart';

import '../../../utils/new_text_field.dart';

class AutoSearch extends StatefulWidget {
  const AutoSearch({super.key});

  @override
  State<AutoSearch> createState() => _AutoSearchState();
}

class _AutoSearchState extends State<AutoSearch> {
  TextEditingController searchLocationController = TextEditingController();
  GetPlaces getPlaces = GetPlaces();
  bool isAddressSelected = false;

  void _navigateToMap(lat, lng) async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          lat: lat,
          lng: lng,
        ),
      ),
    );
    if (selectedAddress != null) {
      setState(() {
        searchLocationController.text = selectedAddress;
      });
      Navigator.pop(context, selectedAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(title: const Text("Choose address")),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              NewTextField(
                label: "Search Location",
                hintText: 'Type here...',
                controller: searchLocationController,
                onChanged: (String value) {
                  ApiServices().getPlaces(value.toString()).then((places) {
                    setState(() {
                      getPlaces = places;
                      isAddressSelected = false;
                    });
                  });
                },
              ),
              Visibility(
                visible: !isAddressSelected &&
                    searchLocationController.text.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: getPlaces.predictions.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context,
                              getPlaces.predictions[index].description);
                        },
                        leading: const Icon(Icons.location_on_sharp),
                        title: Text(getPlaces.predictions[index].description
                            .toString()),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible:
                    isAddressSelected || searchLocationController.text.isEmpty,
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      determinePosition().then((value) {
                        _navigateToMap(value.latitude, value.longitude);
                      }).onError((error, stackTrace) {
                        showErrorSnackBar(
                          context,
                          "Location Error: ${error.toString()}",
                        );
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(FontAwesomeIcons.locationCrosshairs),
                        SizedBox(width: 10),
                        Text('Current Location'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
