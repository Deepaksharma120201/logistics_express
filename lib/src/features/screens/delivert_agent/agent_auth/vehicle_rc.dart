import 'package:flutter/material.dart';
import 'package:logistics_express/src/common_widgets/form/form_text_field.dart';
import 'package:logistics_express/src/common_widgets/form/take_image.dart';
import 'package:logistics_express/src/features/screens/delivert_agent/agent_auth/profile_info.dart';

class VehicleRc extends StatelessWidget {
  const VehicleRc({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          title: const Text('Vehicle RC'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help_outline),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TakeImage(text: 'Upload Front-side'),
              const SizedBox(height: 14),
              const TakeImage(text: 'Upload Back-side'),
              const SizedBox(height: 25),
              FormTextField(
                label: 'Enter vehicle no.',
                hintText: 'Enter here',
                keyboardType: TextInputType.number,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.error_outline),
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ProfileInfo(),
                      ),
                    );
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
