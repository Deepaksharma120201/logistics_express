import 'package:flutter/material.dart';
import 'package:logistics_express/src/models/faq_model.dart';

class DeliveryAgentFaq extends StatelessWidget {
  final List<FAQ> faqList = [
    FAQ(
      question: "How do I update my personal profile information?",
      answer:
          "Tap the 'Profile Info' button, make changes to your name, phone number, or email, and save the updates.",
    ),
    FAQ(
      question: "What is the purpose of uploading my driving license?",
      answer:
          "Uploading your driving license ensures compliance with platform requirements and validates your ability to use the service.",
    ),
    FAQ(
      question: "How do I upload or update my driving license?",
      answer:
          "Tap the 'Driving License' button, select your license image from your device, and upload it. Ensure the details are clear and valid.",
    ),
    FAQ(
      question: "Why do I need to upload my Vehicle RC?",
      answer:
          "Uploading your Vehicle Registration Certificate (RC) confirms the ownership and legality of the vehicle you plan to use for the service.",
    ),
    FAQ(
      question: "How do I upload or update my Vehicle RC?",
      answer:
          "Tap the 'Vehicle RC' button, select the RC document from your device, and upload it. Ensure the document is complete and legible.",
    ),
    FAQ(
      question: "What should I do if my uploaded documents are rejected?",
      answer:
          "Ensure the documents are valid, clear, and not expired. Re-upload them using the respective options.",
    ),
    FAQ(
      question: "Can I delete my uploaded documents?",
      answer:
          "No, documents cannot be deleted once uploaded, but you can replace them with updated versions if needed.",
    ),
    FAQ(
      question: "What file formats are supported for uploading documents?",
      answer:
          "Supported file formats include JPEG, PNG, and PDF. Ensure the file size is within the allowed limit.",
    ),
    FAQ(
      question: "How long does it take to verify my uploaded documents?",
      answer:
          "Document verification typically takes 24-48 hours. You will be notified once the process is complete.",
    ),
    FAQ(
      question: "Who can access my uploaded documents?",
      answer:
          "Only authorized personnel can access your documents to verify your profile. Your data is protected under our privacy policy.",
    ),
  ];

  DeliveryAgentFaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView.builder(
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
      ),
    );
  }
}