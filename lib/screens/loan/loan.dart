import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:perumpallil_augg/Backend/provider/auth_provider.dart';
import 'package:perumpallil_augg/screens/loan/subscription_home_row.dart';
import 'package:perumpallil_augg/models/payment_date_amount.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({Key? key}) : super(key: key);
  static const String id = 'loan';

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      CustomerDetailsStream();
      context.read<AuthProvider>().getDataFromFirestore();
    });
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> CustomerDetailsStream() async {
    AuthProvider ap = Provider.of<AuthProvider>(context, listen: false);

    print(ap.userModel.phoneNumber);
    print(ap.userModel.name);
    print('User Model: ${ap.userModel}');

    // Check if phoneNumber is valid
    if (ap.userModel.phoneNumber.length >= 4) {
      // Remove the country code from the phone number
      String userPhoneNumber = ap.userModel.phoneNumber.substring(3);
      print(userPhoneNumber);

      try {
        final snapshot = await _firebaseFirestore
            .collection('Customers_Details')
            .where('MOB1', isEqualTo: userPhoneNumber)
            .get();

        if (snapshot.docs.isNotEmpty) {
          var message = snapshot.docs.first;
          var pCode = message.data()['PCODE'];
          var refNo = message.data()['RefNo'];
          var fName = message.data()['FNNO'];
          var mob1 = message.data()['MOB1'];

          print('PCODE: $pCode, RefNo: $refNo, FNNO: $fName, MOB1: $mob1');

          // Assuming there's a field named 'date' in your document
          var date = message.data()['date'];
          print('Date: $date');
        } else {
          print('No document found with the specified phone number');
        }
      } catch (error) {
        print('Error in try: $error');
      }
    } else {
      print('Invalid phone number format');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = makeit();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 197, 11, 11),
        toolbarHeight: 0,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 350,
              child: _buildHeader(context),
            ),
            SizedBox(
              height: 20,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction History',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildTransactionHistory(context, filteredData),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final ap = context.watch<AuthProvider>();
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 197, 11, 11),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 340,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Container(
                    height: 40,
                    width: 40,
                    color: const Color.fromRGBO(250, 250, 250, 0.1),
                    child: const Icon(
                      Icons.notification_add_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //USER_NAME
                    Text(
                      ap.userModel.phoneNumber ?? 'Loading...',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromARGB(255, 224, 223, 223),
                      ),
                    ),
                    Text(
                      'Good afternoon',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromARGB(255, 224, 223, 223),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 150,
          left: 37,
          child: Container(
            height: 170,
            width: 320,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(33, 5, 5, 0.615),
                  offset: Offset(0, 20),
                  blurRadius: 22,
                  spreadRadius: 3,
                ),
              ],
              color: const Color.fromARGB(255, 138, 0, 0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Loan Amount',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        '₹ 200000',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTransactionColumn(
                        icon: Icons.arrow_downward,
                        label: 'Income',
                      ),
                      _buildTransactionColumn(
                        icon: Icons.date_range,
                        label: 'Due Date',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ Income',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '07-aug-23',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionColumn(
      {required IconData icon, required String label}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 13,
          backgroundColor: const Color.fromARGB(255, 188, 18, 18),
          child: Icon(
            icon,
            color: Colors.grey,
            size: 19,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Color.fromARGB(255, 216, 216, 216),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionHistory(
      BuildContext context, List<Map<String, dynamic>> filteredData) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                var sObj = filteredData[index];
                return SubScriptionHome(
                  sObj: sObj,
                  onPressed: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
