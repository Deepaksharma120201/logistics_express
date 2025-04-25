import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> sendNotification(
    String subscriptionId, String message, String status) async {
  // print('App ID: ${dotenv.env['ONESIGNAL_APP_ID']}');
  // print('API Key: ${dotenv.env['ONESIGNAL_API_KEY']}');

  // String appId = dotenv.env['ONESIGNAL_APP_ID']!;
  // String appKey = dotenv.env['ONESIGNAL_API_KEY']!;

  String appId = "ba8e538d-d5ec-4ef8-b5b1-b840d2949122";
  String appKey =
      "os_v2_app_xkhfhdov5rhprnnrxbanfferelhqosfts7xerxeli4k453ong2oe5ov4hzgr5l637eifayprqw43gnvywklgdor5yj4wgiigi57bm7i";

  final url = Uri.parse('https://api.onesignal.com/notifications/');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Key $appKey',
    },
    body: jsonEncode({
      'app_id': appId,
      'include_player_ids': [subscriptionId],
      'headings': {'en': status},
      'contents': {'en': message},
    }),
  );

  if (response.statusCode == 200) {
    debugPrint('Notification sent successfully: ${response.body}');
  } else {
    debugPrint(
      'Failed to send notification: ${response.statusCode}, ${response.body}',
    );
  }
}

Future<String?> getSubscriptionId() async {
  final sId = OneSignal.User.pushSubscription.id;
  return sId;
}
