import 'package:uuid/uuid.dart';

class SpecificRequestModel {
  final String id;
  final String? agentName;
  final String? agentPhoneNo;
  final String vehicleType;
  final String startDate;
  final String endDate;
  final String itemType;
  final String source;
  final String destination;
  final String weight;
  final String volume;
  final bool? isPending;

  SpecificRequestModel({
    String? id,
    this.agentName,
    this.agentPhoneNo,
    required this.startDate,
    required this.endDate,
    required this.itemType,
    required this.vehicleType,
    required this.source,
    required this.destination,
    required this.weight,
    required this.volume,
    this.isPending = true,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "Name": agentName,
      "Phone": agentPhoneNo,
      "Date": startDate,
      "EndDate": endDate,
      "ItemType": itemType,
      "Source": source,
      "Destination": destination,
      "Weight": weight,
      "Volume": volume,
      'IsPending': isPending,
      'VehicleType': vehicleType,
    };
  }

  // Create an instance from a Firestore document
  factory SpecificRequestModel.fromMap(Map<String, dynamic> map) {
    return SpecificRequestModel(
      id: map['id'],
      agentName: map['AgentName'] ?? '',
      agentPhoneNo: map['AgentPhone'] ?? '',
      source: map['Source'] ?? '',
      destination: map['Destination'] ?? '',
      startDate: map['Date'] ?? '',
      endDate: map["EndDate"] ?? '',
      weight: map['Weight'] ?? '',
      volume: map['Volume'] ?? '',
      itemType: map['ItemType'] ?? '',
      isPending: map['IsPending'],
      vehicleType: map['VehicleType'],
    );
  }
}
