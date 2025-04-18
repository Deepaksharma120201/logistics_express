import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class UpiPaymentScreen extends StatefulWidget {
  final String upi;
  final String name;
  final String amount;

  const UpiPaymentScreen({
    super.key,
    required this.amount,
    required this.name,
    required this.upi,
  });

  @override
  _UpiPaymentScreenState createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  final Color primaryColor = Colors.blue.shade900;

  final TextStyle header = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  final TextStyle value = const TextStyle(
    fontSize: 14,
  );

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: widget.upi,
      receiverName: widget.name,
      transactionRefId: 'Txn_${DateTime.now().millisecondsSinceEpoch}',
      transactionNote: 'Payment to ${widget.name}',
      amount: double.parse(widget.amount),
      merchantId: '',
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (apps!.isEmpty) {
      return Center(
        child: Text("No UPI apps found.", style: header),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: apps!.map((UpiApp app) {
            return GestureDetector(
              onTap: () {
                _transaction = initiateTransaction(app);
                setState(() {});
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      app.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'UPI app not installed';
      case UpiIndiaUserCancelledException:
        return 'Transaction cancelled';
      case UpiIndiaNullResponseException:
        return 'No response from UPI app';
      case UpiIndiaInvalidParametersException:
        return 'Invalid transaction parameters';
      default:
        return 'Unknown error occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Unknown status');
    }
  }

  Widget displayTransactionData(String title, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title:", style: header),
          Flexible(
            child: Text(
              body,
              style: value,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("UPI Payment"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Choose a UPI app to pay ₹${widget.amount}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: displayUpiApps()),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<UpiResponse>(
              future: _transaction,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        _upiErrorHandler(snapshot.error.runtimeType),
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }

                  final response = snapshot.data!;
                  _checkTxnStatus(response.status ?? '');

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Transaction Details",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            displayTransactionData('Transaction Id',
                                response.transactionId ?? 'N/A'),
                            displayTransactionData('Response Code',
                                response.responseCode ?? 'N/A'),
                            displayTransactionData('Reference Id',
                                response.transactionRefId ?? 'N/A'),
                            displayTransactionData('Status',
                                response.status?.toUpperCase() ?? 'N/A'),
                            displayTransactionData(
                                'Approval No', response.approvalRefNo ?? 'N/A'),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
