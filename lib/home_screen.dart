import 'package:flutter/material.dart';
import 'package:logistics_express/header.dart';
// import 'package:logistics_express/Theme/theme.dart';
import 'package:logistics_express/signup_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                  child: Header(
                    currentLogo: "mainLogo",
                    imageSize: 150,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
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
                          children: [
                            Container(
                              width: 160,
                              height: 160,
                              padding: const EdgeInsets.fromLTRB(12, 18, 10, 0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/customer.png",
                                    width: 90,
                                    height: 82,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupPage()),
                                      );
                                    },
                                    child: Text("Customer"),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 46),
                            Container(
                              width: 160,
                              height: 160,
                              padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/deliveryAgent.png",
                                    width: 80,
                                    height: 80,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupPage()),
                                      );
                                    },
                                    child: Text("Delivery Agent"),
                                  )
                                ],
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
          ],
        ),
      ),
    );
  }
}
