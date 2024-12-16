import 'package:flutter/material.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/custom_widgets/take_image.dart';
import 'package:logistics_express/src/features/screens/delivert_agent/agent_auth/vehicle_rc.dart';

class DrivingLicence extends StatelessWidget {
  const DrivingLicence({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          title: const Text('Driving Licence'),
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
                label: 'Driving Licence No.',
                hintText: 'Enter here',
                keyboardType: TextInputType.number,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.error_outline),
                ),
              ),
              const SizedBox(height: 15),
              const Text('Eg: KA12345677899029'),
              const SizedBox(height: 5),
              const Text('Special characters are not allowed'),
              const SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => VehicleRc(),
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
