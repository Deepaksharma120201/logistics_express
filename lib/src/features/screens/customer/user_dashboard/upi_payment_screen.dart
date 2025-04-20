import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.amount,
    required this.upiAddress,
    required this.name,
  });

  final String amount;
  final String upiAddress;
  final String name;

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<ApplicationMeta>? _apps;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 0), () async {
      _apps = await UpiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all);
      setState(() {});
    });
  }

  Future<void> _onTap(ApplicationMeta app) async {
    final transactionRef = Random.secure().nextInt(1 << 32).toString();

    // ignore: unused_local_variable
    final a = await UpiPay.initiateTransaction(
      amount: widget.amount,
      app: app.upiApplication,
      receiverName: widget.name,
      receiverUpiAddress: widget.upiAddress,
      transactionRef: transactionRef,
      transactionNote: 'UPI Payment',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI Payment'),
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: <Widget>[
            _androidApps(),
          ],
        ),
      ),
    );
  }

  Widget _androidApps() {
    return Container(
      margin: EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              'Pay Using',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          if (_apps != null) _appsGrid(_apps!.map((e) => e).toList()),
        ],
      ),
    );
  }

  GridView _appsGrid(List<ApplicationMeta> apps) {
    apps.sort((a, b) => a.upiApplication
        .getAppName()
        .toLowerCase()
        .compareTo(b.upiApplication.getAppName().toLowerCase()));
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      physics: NeverScrollableScrollPhysics(),
      children: apps
          .map(
            (it) => Material(
              key: ObjectKey(it.upiApplication),
              child: InkWell(
                onTap: () async => await _onTap(it),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    it.iconImage(48),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      alignment: Alignment.center,
                      child: Text(
                        it.upiApplication.getAppName(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
