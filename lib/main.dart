import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:perumpallil_augg/Backend/provider/auth_provider.dart';
import 'package:perumpallil_augg/screens/loan/loan.dart';

import 'package:perumpallil_augg/screens/nav/navigationHome.dart';
import 'package:perumpallil_augg/screens/nav/tab_index_provider.dart';
import 'package:perumpallil_augg/screens/onboarding_screen.dart';
import 'package:perumpallil_augg/screens/register.dart';
import 'package:perumpallil_augg/screens/welcome_screen.dart';
// Import the TabIndexProvider

void main() async {
  Stripe.publishableKey =
      "pk_test_51Nfu1SSEz5owSKwbpjYYYe78Z9IBjAxN2qBEMopYHwqV7Ez46Ay8eq9vUKbETQGtw4nY793CdTXazvikf06QJTdf00OLcNqJzf";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => TabIndexProvider()), // Add this line
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SFProText',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.red.shade900,
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          MyBottomNavigation.id: (context) => const MyBottomNavigation(),
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          OnboardingScreen.id: (context) => const OnboardingScreen(),
          MyRegister.id: (context) => const MyRegister(),
          LoanScreen.id: (context) => LoanScreen(),
          // Remove ProfileScreen.id from routes
        },
        home: MyBottomNavigation(), // Set the HomeScreen as the default screen
      ),
    );
  }
}
