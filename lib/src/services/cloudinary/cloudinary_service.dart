import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:logistics_express/src/custom_widgets/firebase_exceptions.dart';

Future<bool> uploadToCloudinary(BuildContext context, File file) async {
  // Retrieve Cloudinary cloud name and preset from environment variables
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

    // Read the response as a string
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonResponse = jsonDecode(responseBody);
      Map<String, String> requiredData = {
        "name": file.path.split("/").last,
        "id": jsonResponse["public_id"],
        "extension": file.path.split(".").last,
        "size": jsonResponse["bytes"].toString(),
        "url": jsonResponse["secure_url"],
        "created_at": jsonResponse["created_at"],
      };

      // await DbService().saveUploadedFilesData(requiredData);
      if (context.mounted) {
        showSuccessSnackBar(context, "Upload successful!");
      }
      return true;
    } else {
      if (context.mounted) {
        showErrorSnackBar(
            context, "Upload failed with status: ${response.statusCode}");
      }
      return false;
    }
  } catch (e) {
    if (context.mounted) {
      showErrorSnackBar(context, "Error occurred during upload: $e");
    }
    return false;
  }
}
