import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class PublishRideModel {
  final String id;
  final String name;
  final String phoneNo;
  final String startDate;
  final String endDate;
  final String vehicleType;
  final String source;
  final String destination;
  final List<GeoPoint>? route;
  final String? startTime;

  PublishRideModel({
    String? id,
    required this.name,
    required this.phoneNo,
    required this.startDate,
    required this.endDate,
    required this.vehicleType,
    required this.source,
    required this.destination,
    this.route,
    this.startTime,
  }) : id = id ?? const Uuid().v4(); // Assign UUID if not provided

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "Name": name,
      "Phone": phoneNo,
      "StartDate": startDate,
      "EndDate": endDate,
      "VehicleType": vehicleType,
      "Source": source,
      "Destination": destination,
      "Route": route,
      "StartTime": startTime,
    };
  }

  // Create an instance from a Firestore document
  factory PublishRideModel.fromMap(Map<String, dynamic> map) {
    return PublishRideModel(
      id: map['id'],
      name: map['Name'] ?? '',
      phoneNo: map['Phone'] ?? '',
      startDate: map['StartDate'] ?? '',
      endDate: map['EndDate'] ?? '',
      vehicleType: map['VehicleType'] ?? '',
      source: map['Source'] ?? '',
      destination: map['Destination'] ?? '',
      route: List<GeoPoint>.from(map['Route'] ?? []),
      startTime: map['StartTime'],
    );
  }
}
