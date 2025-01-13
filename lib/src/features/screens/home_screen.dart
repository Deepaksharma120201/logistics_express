import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistics_express/src/custom_widgets/form_header.dart';
import 'package:logistics_express/src/features/screens/customer/user_auth/login_screen.dart';
import 'package:logistics_express/src/features/screens/customer/user_dashboard/user_dashboard_screen.dart';
import 'package:logistics_express/src/services/authentication/auth_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  flex: 2,
                  child: FormHeader(
                    currentLogo: "main_logo",
                    imageSize: 150,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    // padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 164, 118, 220),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 275),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                ref.read(roleProvider.notifier).state =
                                    "Customer";
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 160,
                                height: 160,
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80)),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/customer.png",
                                      width: 130,
                                      height: 100,
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Customer"),
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(width: 46),
                            GestureDetector(
                              onTap: () {
                                ref.read(roleProvider.notifier).state =
                                    "Delivery Agent";
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 160,
                                height: 160,
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(80),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/deliveryAgent.png",
                                      width: 130,
                                      height: 100,
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Delivery Agent"),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 70,
              bottom: 430,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserHomeScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: 270,
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/bothU&D.png",
                        width: 250,
                        height: 115,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Transport services for"),
                      const Text("quick delivery of your goods."),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
