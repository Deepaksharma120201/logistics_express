import 'package:flutter/material.dart';
import 'package:logistics_express/src/models/faq_model.dart';

class FaqListView extends StatelessWidget {
  final List<FAQ> faqList;

  const FaqListView({super.key, required this.faqList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqList.length,
      itemBuilder: (context, index) {
        final faq = faqList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          child: Card(
            child: ExpansionTile(
              title: Text(
                faq.question,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(faq.answer),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
