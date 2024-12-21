import 'package:flutter/material.dart';
import 'package:logistics_express/src/custom_widgets/form_text_field.dart';
import 'package:logistics_express/src/features/subscreens/sidebar/address_filled.dart';

class PriceEstimation extends StatelessWidget {
  const PriceEstimation({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Price Estimation'),
        ),
        backgroundColor: Theme.of(context).cardColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AddressFilled(),
                const SizedBox(height: 40),
                FormTextField(
                  label: 'Weight',
                  hintText: 'Enter weight in Kg',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                FormTextField(
                  label: 'Volume',
                  hintText: 'Enter volume',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButton<String>(
                      dropdownColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      isExpanded: true,
                      hint: Text('Select type'),
                      items: [],
                      onChanged: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Estimate Price'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
