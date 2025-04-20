import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendNotificationToCustomer(
    String playerId, String customerName) async {
  final url = Uri.parse('https://onesignal.com/api/v1/notifications');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Basic hqosfts7xerxeli4k453ong2o'
    },
    body: jsonEncode({
      'app_id': 'ba8e538d-d5ec-4ef8-b5b1-b840d2949122',
      'include_player_ids': "256d4c48-fbe0-4603-9127-4975368edb7a",
      'headings': {'en': 'Delivery Accepted'},
      'contents': {'en': '$customerName, your delivery has been accepted!'},
    }),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully: ${response.body}');
  } else {
    print(
        'Failed to send notification: ${response.statusCode}, ${response.body}');
  }
}

// Future<void> getAndSavePlayerId() async {
//   final playerid = OneSignal.User.pushSubscription.id;
//   print("The devices state : $playerid");
// }
