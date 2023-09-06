// ignore_for_file: file_names
// // ignore: file_names
// // ignore: file_names
// // ignore_for_file: unused_local_variable, duplicate_ignore, file_names
//
// import 'dart:convert';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
//
// import 'package:flutter/material.dart';
//
// // ignore: unnecessary_import
// import 'package:flutter/services.dart';
//
// import 'package:united21/screens/loan/loan.dart';
//
// import '../../../common/color_extension.d
//
// // ignore: use_key_in_widget_constructors
// class MyBottomNavigationLoan extends StatefulWidget {
//   @override
//   State<MyBottomNavigationLoan> createState() => _MyBottomNavigationLoanState();
// }
//
// class _MyBottomNavigationLoanState extends State<MyBottomNavigationLoan> {
//   Map<String, dynamic>? paymentIntent;
//   int selectTab = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               ColorFiltered(
//                 colorFilter: const ColorFilter.mode(
//                   Colors.black, // Change this color to the desired tint color
//                   BlendMode.modulate,
//                 ),
//                 child: Image.asset("assets/images/bottom_bar_bg.png"),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         selectTab = 0;
//                         var currentTabView = LoanScreen();
//                       });
//                     },
//                     icon: Image.asset(
//                       "assets/images/home.png",
//                       width: 20,
//                       height: 20,
//                       color:
//                           selectTab == 0 ? TColor.redshade500 : TColor.gray30,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         selectTab = 1;
//                         // ignore: unused_local_variable
//                         var currentTabView = LoanScreen();
//                       });
//                     },
//                     icon: Image.asset(
//                       "assets/images/budgets.png",
//                       width: 20,
//                       height: 20,
//                       color:
//                           selectTab == 1 ? TColor.redshade500 : TColor.gray30,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 50,
//                     height: 50,
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         selectTab = 2;
//                         var currentTabView = CalenderView();
//                       });
//                     },
//                     icon: Image.asset(
//                       "assets/images/calendar.png",
//                       width: 20,
//                       height: 20,
//                       color:
//                           selectTab == 2 ? TColor.redshade500 : TColor.gray30,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         selectTab = 3;
//                         var currentTabView = CardsView();
//                       });
//                     },
//                     icon: Image.asset(
//                       "assets/images/creditcards.png",
//                       width: 20,
//                       height: 20,
//                       color:
//                           selectTab == 3 ? TColor.redshade500 : TColor.gray30,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => LoanScreen()));
//             },
//             child: Container(
//               margin: const EdgeInsets.all(16),
//               decoration: BoxDecoration(boxShadow: [
//                 BoxShadow(
//                     color: TColor.secondary.withOpacity(0.25),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4))
//               ], borderRadius: BorderRadius.circular(50)),
//               child: CircleAvatar(
//                 radius: 32,
//                 backgroundColor: Colors.red.shade900,
//                 child: IconButton(
//                   color: Colors.white,
//                   onPressed: () => makepayment("100", "INR"),
//                   icon: const Icon(
//                     Icons.payment,
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Map<String, dynamic>? paymentIntentData;
//   Future<void> makepayment(String amount, String currency) async {
//     //1. paymnet Intent
//     try {
//       paymentIntentData = await createPaymentIntent(amount, currency);
//       var gpay = PaymentSheetGooglePay(
//           merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);
//
//       if (paymentIntentData != null) {
//         await Stripe.instance.initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//                 //applepay:true,
//                 googlePay: gpay,
//                 merchantDisplayName: "perummpallil finanace",
//                 customerId: paymentIntentData!['customer'],
//                 paymentIntentClientSecret: paymentIntentData!['client_secret'],
//                 customerEphemeralKeySecret:
//                     paymentIntentData!['ephemeralkey']));
//         displayPaymentSheet();
//       }
//     } catch (error) {
//       throw Exception(error);
//     }
//   }
//
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       var response = await http.post(
//           Uri.parse("https://api.stripe.com/v1/payment_intents"),
//           body: body,
//           headers: {
//             'Authorization':
//                 "Bearer sk_test_51Nfu1SSEz5owSKwb6jMwpZfGwaa1C6Fe7EHvlV4s6CwgaDaVQpFTShtSAdhdKOm3Qf4db4fSN1r3K9cwFDnINSHX00ySss7NWz",
//             'content-Type': 'application/x-www-form-urlencoded'
//           });
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user $err');
//     }
//   }
//
//   void displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       Get.snackbar('payment info', 'pay sucessfull');
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         print('error from Stripe $e');
//       } else {
//         print('Unforeseen error $e');
//       }
//     } catch (e) {
//       print("exception===$e");
//     }
//   }
//
//   calculateAmount(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }
// }
//
// class CardsView {}
//
// class CalenderView {}
