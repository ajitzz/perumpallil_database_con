// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:perumpallil_augg/Backend/provider/auth_provider.dart';

import 'package:perumpallil_augg/screens/nav/navigationHome.dart';
import 'package:perumpallil_augg/screens/phone_auth/register_phone.dart';

import 'package:perumpallil_augg/widgets/custom_button.dart';
import 'package:provider/provider.dart';
// import 'package:perumpallil_augg/provider/auth_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.red.shade900,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 70.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'PERUMPALLIL',
              textAlign: TextAlign.center, // Center the text
              style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            Text(
              'FINANCE',
              textAlign: TextAlign.center, // Center the text
              style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.amber.shade300),
            ),
            const SizedBox(
              height: 158.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                onPressed: () async {
                  if (ap.isSignedIn == true) {
                    await ap.getDataFromSP().whenComplete(
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyBottomNavigation(),
                            ),
                          ),
                        );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  }
                },
                text: "Get started",
              ),
            )
          ],
        ),
      ),
    );
  }
}
