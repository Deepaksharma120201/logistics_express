import 'package:flutter/material.dart';
import 'package:logistics_express/src/services/authentication/auth_service.dart';

class AgentHomeScreen extends StatefulWidget {
  const AgentHomeScreen({super.key});

  @override
  State<AgentHomeScreen> createState() {
    return _AgentHomeScreenState();
  }
}

class _AgentHomeScreenState extends State<AgentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () => authService.signOut(context),
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Container(),
    );
  }
}
