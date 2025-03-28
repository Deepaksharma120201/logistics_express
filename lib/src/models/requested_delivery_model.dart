import 'package:uuid/uuid.dart';

class RequestedDeliveryModel {
  final String id;
  final String? name;
  final String? phoneNo;
  final String date;
  final String itemType;
  final String source;
  final String destination;
  final String weight;
  final String volume;
  final bool? isPending;

  RequestedDeliveryModel({
    String? id,
    this.name,
    this.phoneNo,
    required this.date,
    required this.itemType,
    required this.source,
    required this.destination,
    required this.weight,
    required this.volume,
    this.isPending = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "Name": name,
      "Phone": phoneNo,
      "Date": date,
      "ItemType": itemType,
      "Source": source,
      "Destination": destination,
      "Weight": weight,
      "Volume": volume,
      'IsPending': isPending,
    };
  }

  // Create an instance from a Firestore document
  factory RequestedDeliveryModel.fromMap(Map<String, dynamic> map) {
    return RequestedDeliveryModel(
      id: map['id'],
      name: map['Name'] ?? '',
      phoneNo: map['Phone'] ?? '',
      source: map['Source'] ?? '',
      destination: map['Destination'] ?? '',
      date: map['Date'] ?? '',
      weight: map['Weight'] ?? '',
      volume: map['Volume'] ?? '',
      itemType: map['ItemType'] ?? '',
      isPending: map['IsPending'],
    );
  }
}
