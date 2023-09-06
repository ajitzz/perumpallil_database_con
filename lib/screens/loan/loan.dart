import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perumpallil_augg/Backend/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:perumpallil_augg/screens/loan/subscription_home_row.dart';
import 'package:perumpallil_augg/models/payment_date_amount.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({Key? key}) : super(key: key);
  static const String id = 'loan';

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  String? detailName;

  int? detailMobile;

  int? detailPCode;
  int? detailRefNo;

  String? detailFnNo;
  String? detailKsDate;
  String? detailPDate;
  String? detailAddress1;
  String? detailAddress2;
  String? detailClose;

  //snapshot_payments
  String? paymentfdate;
  int? paymentHCODE;
  int? paymentCREDIT;
  int? paymentDEBIT;
  String? paymentPURP;
  String? paymentFN_NUM;
  int? paymentSNO;
  int? paymentPCODE;
  int? paymentPAY;

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getDataFromFirestore();
    CustomerDetailsStream();
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> CustomerDetailsStream() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final snapshot_details =
          await _firebaseFirestore.collection('Customers_Details').get();
      final snapshot_payments =
          await _firebaseFirestore.collection('Customers_payments').get();

      if (snapshot_details.docs.isNotEmpty) {
        final detail = snapshot_details.docs[0].data();
        final detailMobile = detail['MOB1'] as int;
        print('$detailMobile');

        if ('+91$detailMobile'
            .contains('${authProvider.userModel.phoneNumber}')) {
          // Cast the values appropriately based on their types in Firestore
          final detailPCode = detail['PCODE'] as int;
          final detailRefNo = detail['RefNo'] as int;
          final detailFnNo = detail['FNNO'] as String;
          final detailName = detail['PNAME'] as String;
          final detailKsDate = detail['KSdate'] as String;
          final detailPDate = detail['PDATE'] as String;
          final detailAddress1 = detail['ADD2'] as String;
          final detailAddress2 = detail['ADD3'] as String;
          final detailClose = detail['Column5'] as String;
          // final detailMobile = detail['MOB1'] as int;

          setState(() {
            print('${this.detailName = detailName}');
            print('${this.detailMobile = detailMobile}');
            print('${this.detailPCode = detailPCode}');
            print('${this.detailRefNo = detailRefNo}');
            print('${this.detailFnNo = detailFnNo}');
            print('${this.detailKsDate = detailKsDate}');
            print('${this.detailPDate = detailPDate}');
            print('${this.detailAddress1 = detailAddress1}');
            print('${this.detailAddress2 = detailAddress2}');
            print('${this.detailClose = detailClose}');
          });
        } else {
          print('MOB1 does not contain phoneNumber in user_Details');
        }
      } else {
        print('No documents snapshots are found, doc is empty');
      }

      //user_payments
      if (snapshot_payments.docs.isNotEmpty) {
        final payment = snapshot_payments.docs[0].data();
        final paymentPCODE = payment['PCODE'] as int;
        print('$detailPCode');
        print('$paymentPCODE');

        if ('$paymentPCODE'.contains('$detailPCode')) {
          // Cast the values appropriately based on their types in Firestore
          final paymentfdate = payment['fdate'] as String;
          final paymentHCODE = payment['HCODE'] as int;
          final paymentCREDIT = payment['CREDIT'] as int;
          final paymentDEBIT = payment['DEBIT'] as int;
          final paymentPURP = payment['PURP'] as String;
          final paymentFN_NUM = payment['FN_NUM'] as String;
          final paymentSNO = payment['SNO'] as int;
          final paymentPCODE = payment['PCODE'] as int;
          final paymentPAY = payment['PAY'] as int;

          setState(() {
            print('${this.paymentfdate = paymentfdate}');
            print('${this.paymentHCODE = paymentHCODE}');
            print('${this.paymentCREDIT = paymentCREDIT}');
            print('${this.paymentDEBIT = paymentDEBIT}');
            print('${this.paymentPURP = paymentPURP}');
            print('${this.paymentFN_NUM = paymentFN_NUM}');
            print('${this.paymentSNO = paymentSNO}');
            print('${this.paymentPCODE = paymentPCODE}');
            print('${this.paymentPAY = paymentPAY}');
          });
        } else {
          print('detail code does not contain payment_code in user_payments');
        }
      } else {
        print('No documents snapshots are found, doc is empty');
      }
    } catch (error) {
      // Handle any errors that occur during data retrieval.
      print('Error: $error');
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
                      detailName ?? 'Loading...',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromARGB(255, 224, 223, 223),
                      ),
                    ),
                    // PHONE NUMBER
                    // Text(
                    //   detailMobile != null
                    //       ? detailMobile.toString()
                    //       : 'Loading...',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 16,
                    //     color: Color.fromARGB(255, 224, 223, 223),
                    //   ),
                    // ),
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
