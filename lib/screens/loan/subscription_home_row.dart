// ignore_for_file: unnecessary_string_escapes, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:perumpallil_augg/widgets/custom_button.dart';
import '../../common/color_extension.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

// ignore: must_be_immutable
class SubScriptionHome extends StatelessWidget {
  final Map<String, dynamic> sObj;
  final VoidCallback onPressed;

  SubScriptionHome({
    Key? key,
    required this.sObj,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Container(
          height: 64,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 238, 238),
            border: Border.all(
              color: TColor.border.withOpacity(0.15),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              Image.asset(
                sObj["icon"],
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sObj["Date"],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "\₹${sObj["price"]}",
                    style: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                // text: "\$${sObj["price"]}",
                text: "Pay",
                onPressed: () => makepayment("100", "INR"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic>? paymentIntentData;
  Future<void> makepayment(String amount, String currency) async {
    //1. paymnet Intent
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);

      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                //applepay:true,
                googlePay: gpay,
                merchantDisplayName: "perummpallil finanace",
                customerId: paymentIntentData!['customer'],
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerEphemeralKeySecret:
                    paymentIntentData!['ephemeralkey']));
        displayPaymentSheet();
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            'Authorization':
                "Bearer sk_test_51Nfu1SSEz5owSKwb6jMwpZfGwaa1C6Fe7EHvlV4s6CwgaDaVQpFTShtSAdhdKOm3Qf4db4fSN1r3K9cwFDnINSHX00ySss7NWz",
            'content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user $err');
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('payment info', 'pay sucessfull');
    } on Exception catch (e) {
      if (e is StripeException) {
        print('error from Stripe $e');
      } else {
        print('Unforeseen error $e');
      }
    } catch (e) {
      print("exception===$e");
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
