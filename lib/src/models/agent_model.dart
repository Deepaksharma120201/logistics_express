class AgentModel {
  final String id;
  final String name;
  final String phoneNo;
  final String date;
  final String aadhar;
  final String gender;
  final String profileImageUrl;
  final String? dlFrontImageUrl;
  final String? dlBackImageUrl;
  final String? dlNumber;
  final String? rcFrontImageUrl;
  final String? rcBackImageUrl;
  final String? rcNumber;

  const AgentModel({
    required this.id,
    required this.date,
    required this.name,
    required this.phoneNo,
    required this.aadhar,
    required this.gender,
    required this.profileImageUrl,
    this.dlBackImageUrl = "",
    this.dlFrontImageUrl = "",
    this.rcBackImageUrl = "",
    this.rcFrontImageUrl = "",
    this.rcNumber = "",
    this.dlNumber = "",
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "Name": name,
      "Phone": phoneNo,
      "Date": date,
      "Aadhar": aadhar,
      "Gender": gender,
      "ProfileImageUrl": profileImageUrl,
      "DLFrontImageUrl": dlFrontImageUrl,
      "DLBackImageUrl": dlBackImageUrl,
      "DLNumber": dlNumber,
      "RCFrontImageUrl": rcFrontImageUrl,
      "RCBackImageUrl": rcBackImageUrl,
      "RCNumber": rcNumber,
    };
  }

  // Create an instance from a Firestore document
  factory AgentModel.fromMap(Map<String, dynamic> map) {
    return AgentModel(
      id: map['id'],
      name: map['Name'] ?? '',
      phoneNo: map['Phone'] ?? '',
      date: map['Date'] ?? '',
      aadhar: map['Aadhar'] ?? '',
      gender: map['Gender'] ?? '',
      profileImageUrl: map['ProfileImageUrl'] ?? '',
      dlFrontImageUrl: map['DLFrontImageUrl'] ?? '',
      dlBackImageUrl: map['DLBackImageUrl'] ?? '',
      dlNumber: map['DLNumber'] ?? '',
      rcFrontImageUrl: map['RCFrontImageUrl'] ?? '',
      rcBackImageUrl: map['RCBackImageUrl'] ?? '',
      rcNumber: map['RCNumber'] ?? '',
    );
  }
}
