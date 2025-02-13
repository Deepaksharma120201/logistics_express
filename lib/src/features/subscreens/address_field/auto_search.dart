import 'package:flutter/material.dart';
import 'package:logistics_express/src/services/map_services/api_services.dart';
import 'package:logistics_express/src/services/map_services/get_places.dart';
import 'package:logistics_express/src/services/map_services/location_permission.dart';
import 'package:logistics_express/src/services/map_services/map_screen.dart';

class AutoSearch extends StatefulWidget {
  const AutoSearch({super.key});

  @override
  State<AutoSearch> createState() => _AutoSearchState();
}

class _AutoSearchState extends State<AutoSearch> {
  TextEditingController searchLocationController = TextEditingController();
  GetPlaces getPlaces = GetPlaces();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(title: const Text("Screen")),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Search Location...'),
              controller: searchLocationController,
              onChanged: (String value) {
                ApiServices().getPlaces(value.toString()).then((value) {
                  setState(() {
                    getPlaces = value;
                  });
                });
              },
            ),
            Visibility(
              visible: searchLocationController.text.isEmpty ? false : true,
              child: Expanded(
                child: ListView.builder(
                  itemCount: getPlaces.predictions?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        ApiServices()
                            .getCoordinatesFromPlaceId(
                                getPlaces.predictions?[index].placeId ?? "")
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                  lat: value.result?.geometry?.location?.lat ??
                                      0.0,
                                  lng: value.result?.geometry?.location?.lng ??
                                      0.0,
                                ),
                              ));
                        }).onError((error, stackTrace) {
                          print('Error ${error.toString()}');
                        });
                      },
                      leading: const Icon(Icons.location_on_sharp),
                      title: Text(
                          getPlaces.predictions![index].description.toString()),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: searchLocationController.text.isEmpty ? true : false,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    onPressed: () {
                      determinePosition().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                lat: value.latitude,
                                lng: value.longitude,
                              ),
                            ));
                      }).onError((error, stackTrace) {
                        print("Location Error: ${error.toString()}");
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.my_location, color: Colors.purple),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Current Location'),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
