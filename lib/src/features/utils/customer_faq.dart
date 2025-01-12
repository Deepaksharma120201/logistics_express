import 'package:flutter/material.dart';
import 'package:logistics_express/src/custom_widgets/faq_list_view.dart';
import 'package:logistics_express/src/models/faq_model.dart';

class CustomerFaq extends StatelessWidget {
  final List<FAQ> faqList = [
    FAQ(
      question: "How do I book a ride for my delivery?",
      answer:
          "To book a ride, tap the 'Search Ride' button. Enter your pick-up and drop-off locations, then choose from the available ride options.",
    ),
    FAQ(
      question: "How can I request a delivery service?",
      answer:
          "Tap 'Make Request' on the dashboard, fill in details like package type, size, and delivery address, and submit the form.",
    ),
    FAQ(
      question: "Where can I check the status of my requests?",
      answer:
          "Go to 'See Requested Rides' to view all your ride or delivery requests, including their current status and details.",
    ),
    FAQ(
      question: "How can I track my package after booking a delivery?",
      answer:
          "Tap 'Track Delivery' and enter your tracking ID to see real-time updates about your package's location and delivery status.",
    ),
    FAQ(
      question: "What if I’m unsure about the delivery cost?",
      answer:
          "Use 'Price Estimation' on the dashboard. Enter details such as distance, package size, and weight to get an approximate cost.",
    ),
    FAQ(
      question: "What happens if I need to cancel a ride or delivery?",
      answer:
          "You can cancel a request from the 'See Requested Rides' section. Select the request and tap 'Cancel'. Note: Cancellation fees may apply based on the timing.",
    ),
    FAQ(
      question: "How do I view my previous payments and invoices?",
      answer:
          "Go to 'View Payment History' to see a list of all your completed transactions, including dates, amounts, and service details.",
    ),
    FAQ(
      question: "What should I do if my delivery is delayed?",
      answer:
          "First, check the current status using 'Track Delivery'. If there's still an issue, use the 'Help' section to contact customer support for assistance.",
    ),
    FAQ(
      question: "How do I update my contact or payment details?",
      answer:
          "Tap the menu icon in the top-left corner of the app and navigate to 'Settings' to update your personal or payment information.",
    ),
    FAQ(
      question: "How can I report a problem or provide feedback?",
      answer:
          "Click on the question mark icon in the top-right corner of the dashboard. Use the 'Contact Support' option to share feedback or report an issue.",
    ),
  ];

  CustomerFaq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: FaqListView(faqList: faqList),
    );
  }
}
