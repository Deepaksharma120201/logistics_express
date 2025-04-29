import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class RequestedDeliveryModel {
  final String id;
  final String? dId;
  final String? name;
  final String? phoneNo;
  final String startDate;
  final String? endDate;
  final String itemType;
  final String source;
  final String destination;
  final String weight;
  final String volume;
  String? amount;
  final bool? isPending;
  final bool? isDelivered;
  final String? agentName;
  final String? agentPhoneNo;
  final String? vehicleType;
  final String? upiId;
  final GeoPoint? driverLocation;

  RequestedDeliveryModel({
    String? id,
    this.dId,
    this.name,
    this.phoneNo,
    required this.startDate,
    this.endDate,
    required this.itemType,
    required this.source,
    required this.destination,
    required this.weight,
    required this.volume,
    this.amount,
    this.isPending = true,
    this.isDelivered= false,
    this.agentName,
    this.agentPhoneNo,
    this.vehicleType,
    this.upiId,
    this.driverLocation,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Did':dId,
      'Name': name,
      'Phone': phoneNo,
      'Date': startDate,
      'EndDate': endDate,
      'ItemType': itemType,
      'Source': source,
      'Destination': destination,
      'Weight': weight,
      'Volume': volume,
      'Amount': amount,
      'IsPending': isPending,
      'IsDelivered':isDelivered,
      'AgentName': agentName,
      'AgentPhone': agentPhoneNo,
      'VehicleType': vehicleType,
      'UpiId': upiId,
      'driverLocation': driverLocation,
    };
  }

  factory RequestedDeliveryModel.fromMap(Map<String, dynamic> map) {
    return RequestedDeliveryModel(
      id: map['id'] ?? const Uuid().v4(),
      dId: map['Did'],
      name: map['Name'],
      phoneNo: map['Phone'],
      startDate: map['Date'] ?? '',
      endDate: map['EndDate'],
      itemType: map['ItemType'] ?? '',
      source: map['Source'] ?? '',
      destination: map['Destination'] ?? '',
      weight: map['Weight'] ?? '',
      volume: map['Volume'] ?? '',
      amount: map['Amount'],
      isPending: map['IsPending'],
      isDelivered: map['IsDelivered'],
      agentName: map['AgentName'],
      agentPhoneNo: map['AgentPhone'],
      vehicleType: map['VehicleType'],
      upiId: map['UpiId'],
      driverLocation: map['driverLocation'],
    );
  }
}
