import 'package:flutter/material.dart';
import 'package:perumpallil_augg/screens/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  static String id = 'onboarding_screen';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red.shade900,
        body: SingleChildScrollView(
          // Wrap the entire content in a SingleChildScrollView
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 150.0), //to adjust the whole screen height
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.amber,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.phone_android,
                        color: Colors.grey,
                      ),
                      title: TextField(
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                          letterSpacing: 5,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      title: TextField(
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                          letterSpacing: 5,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        // ignore: avoid_unnecessary_containers
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 25.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              color: Colors.grey,
                              onPressed: () {
                                Navigator.pushNamed(context, HomeScreen.id);
                              },
                              icon: const Icon(
                                Icons.arrow_forward,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                              },
                              style: const ButtonStyle(),
                              child: Text(
                                'Register',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey.shade400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
