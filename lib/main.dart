import 'package:flutter/material.dart';
import '/widgets/custom_card_stack.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Item List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30.0), //top padding with 30 pixels
          child: Column(children: [
            Center(
              child: SizedBox(
                width: 60.0,
                height: 90.0,
                child: Stack(
                  children: [
                    const Text(
                      "Tind...",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Image.asset(
                        "assets/images/tinder_logo.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            const CustomCardStack()
          ]),
        ),
      ),
    );
  }
}

enum SwipeValue { left, right, none }
