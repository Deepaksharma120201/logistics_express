import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:logistics_express/src/features/utils/firebase_exceptions.dart';

Future<String?> uploadToCloudinary(BuildContext context, File file) async {
  // Retrieve Cloudinary cloud name from environment variables
  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

  try {
    // Create a URI for the Cloudinary API
    var uri =
        Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/raw/upload");

    // Prepare a multipart request for file upload
    var request = http.MultipartRequest("POST", uri);

    // Add the file as a multipart file
    var multipartFile = await http.MultipartFile.fromPath(
      'file', // The form field name for the file
      file.path,
    );

    request.files.add(multipartFile);
    request.fields['upload_preset'] = "preset_for_file_upload";
    request.fields['resource_type'] = "raw";

    // Send the request and await the response
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(responseBody);
      String imageUrl = jsonResponse["secure_url"];
      // await DbService().updateProfileUrl(imageUrl);
      
      return imageUrl;
    } else {
      if (context.mounted) {
        showErrorSnackBar(
            context, "Upload failed with status: ${response.statusCode}");
      }
      return null;
    }
  } catch (e) {
    if (context.mounted) {
      showErrorSnackBar(context, "Error occurred during upload: $e");
    }
    return null;
  }
}
