import 'package:flutter/material.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() {
    return _PaymentHistoryState();
  }
}

class _PaymentHistoryState extends State<PaymentHistory> {
  // Example list of payment data (simulate database)
  final List<Map<String, String>> paymentData = [
    {
      "from": "John Doe",
      "to": "Jane Smith",
      "date": "12/12/2023",
      "customer_Name": "Alex Brown",
      "orderId": "12345",
    },
    {
      "from": "Alice Cooper",
      "to": "Bob Marley",
      "date": "11/11/2023",
      "customer_Name": "Chris Evans",
      "orderId": "67890",
    },
    {
      "from": "Peter Parker",
      "to": "Tony Stark",
      "date": "10/10/2023",
      "customer_Name": "Bruce Wayne",
      "orderId": "54321",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: paymentData.length,
        itemBuilder: (context, index) {
          final data = paymentData[index];
          return Card(
            color: const Color(0xFFEDE7F6),
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('From - ${data["from"]}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('To - ${data["to"]}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Date - ${data["date"]}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Customer Name - ${data["customerName"]}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Order id - ${data["orderId"]}',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
