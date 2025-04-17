import 'package:uuid/uuid.dart';

class SpecificRideModel {
  final String id;
  final String customerName;
  final String customerPhoneNo;
  final String startDate;
  final String endDate;
  final String source;
  final String weight;
  final String volume;
  final String itemType;
  final String destination;
  final bool? isPending;

  SpecificRideModel({
    String? id,
    required this.customerName,
    required this.customerPhoneNo,
    required this.startDate,
    required this.endDate,
    required this.source,
    required this.destination,
    required this.weight,
    required this.volume,
    required this.itemType,
    this.isPending = true,
  }) : id = id ?? const Uuid().v4(); // Assign UUID if not provided

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "Name": customerName,
      "Phone": customerPhoneNo,
      "SDate": startDate,
      "EndDate": endDate,
      "Source": source,
      "Destination": destination,
      "ItemType": itemType,
      "Weight": weight,
      'IsPending': isPending,
      "Volume": volume,
    };
  }

  // Create an instance from a Firestore document
  factory SpecificRideModel.fromMap(Map<String, dynamic> map) {
    return SpecificRideModel(
      id: map['id'],
      customerName: map['Name'] ?? '',
      customerPhoneNo: map['Phone'] ?? '',
      startDate: map['Date'] ?? '',
      endDate: map['EndDate'] ?? '',
      source: map['Source'] ?? '',
      destination: map['Destination'] ?? '',
      weight: map['Weight'] ?? '',
      volume: map['Volume'] ?? '',
      isPending: map['IsPending'],
      itemType: map['ItemType'] ?? '',
    );
  }
}
