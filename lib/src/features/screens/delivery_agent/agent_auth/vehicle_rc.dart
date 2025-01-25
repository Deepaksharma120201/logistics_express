import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/take_image.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_auth/driving_licence.dart';
import 'package:logistics_express/src/features/screens/delivery_agent/agent_dashboard/agent_dashboard_screen.dart';

class VehicleRc extends StatefulWidget {
  const VehicleRc({super.key});

  @override
  State<VehicleRc> createState() => _VehicleRcState();
}

class _VehicleRcState extends State<VehicleRc> {
  File? _frontImage;
  File? _backImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          title: const Text('Vehicle RC'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TakeImage(
                text: 'Upload Front-side',
                onImageSelected: (File image) {
                  setState(() {
                    _frontImage = image;
                  });
                },
              ),
              const SizedBox(height: 14),
              TakeImage(
                text: 'Upload Back-side',
                onImageSelected: (File image) {
                  setState(() {
                    _backImage = image;
                  });
                },
              ),
              const SizedBox(height: 25),
              FormTextField(
                label: 'Enter vehicle no.',
                hintText: 'Enter here',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 25),
              Center(
                child: SubmitImage(
                  frontImage: _frontImage,
                  backImage: _backImage,
                  route: (ctx) => const AgentHomeScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
