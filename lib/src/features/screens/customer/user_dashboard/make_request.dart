import 'package:flutter/material.dart';
import 'package:logistics_express/src/features/subscreens/address_field/address_filled.dart';
import '../../../../custom_widgets/custom_dropdown.dart';
import '../../../utils/new_text_field.dart';
import '../../../utils/validators.dart';

class MakeRequest extends StatefulWidget {
  const MakeRequest({super.key});

  @override
  State<MakeRequest> createState() => _MakeRequestState();
}

class _MakeRequestState extends State<MakeRequest> {
  String? _selectedType;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Make Request'),
        ),
        backgroundColor: Theme.of(context).cardColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AddressFilled(),
                const SizedBox(height: 40),
                NewTextField(
                  label: 'Weight',
                  hintText: 'Enter weight in Kg',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                NewTextField(
                  label: 'Volume',
                  hintText: 'Enter volume',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  label: "Select Type",
                  items: [],
                  value: _selectedType,
                  onChanged: (value) => setState(() => _selectedType = value),
                  validator: (val) => Validators.validateDropdown(val!),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Send Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
