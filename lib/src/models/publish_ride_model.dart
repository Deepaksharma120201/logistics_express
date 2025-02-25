class PublishRideModel {
  final String? id;
  final String name;
  final String phoneNo;
  final String startDate;
  final String endDate;
  final String vehicleType;
  final String source;
  final String destination;
  final String? startTime;

  const PublishRideModel({
    this.id,
    required this.name,
    required this.phoneNo,
    required this.startDate,
    required this.endDate,
    required this.vehicleType,
    required this.source,
    required this.destination,
    this.startTime,
  });

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
      "StartTime": startTime,
    };
  }

  // Create an instance from a Firestore document
  factory PublishRideModel.fromMap(Map<String, dynamic> map) {
    return PublishRideModel(
      id: map['id'] ?? '',
      name: map['Name'] ?? '',
      phoneNo: map['Phone'] ?? '',
      startDate: map['StartDate'] ?? '',
      endDate: map['EndDate'] ?? '',
      vehicleType: map['VehicleType'] ?? '',
      source: map['Source'] ?? '',
      destination: map['Destination'] ?? '',
      startTime: map['StartTime'] ?? '',
    );
  }
}
