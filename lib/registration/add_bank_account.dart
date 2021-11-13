import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/registration/verification4.dart';

class AddBankAccountScreen extends StatefulWidget {
  const AddBankAccountScreen({Key? key}) : super(key: key);

  @override
  _AddBankAccountScreenState createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  void uploadBankDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Profile')
        .doc('Bank details')
        .set({
      'Bank name': bankName.text,
      'Account holder': accountHolder.text,
      'Account type': accountType.text,
      'Branch code': branchCode.text,
      'Account number': accountNumber.text,
    });
  }

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountHolder = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final TextEditingController branchCode = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        //  leading:
        //  InkWell(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationPage4(context)),
            );
          },
        ),
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 100,
        centerTitle: true,
        title: new Text(
          'Add bank account',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: bankName,
                            decoration: InputDecoration(
                              labelText: 'Bank Name',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          TextField(
                            controller: accountHolder,
                            decoration: InputDecoration(
                              labelText: 'Account Holder',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          TextField(
                            controller: accountType,
                            decoration: InputDecoration(
                              labelText: 'Account Type',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          TextField(
                            controller: branchCode,
                            decoration: InputDecoration(
                              labelText: 'Branch Code',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          TextField(
                            controller: accountNumber,
                            decoration: InputDecoration(
                              labelText: 'Account Number',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            ElevatedButton(
                child: Text('Add bank account',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins')),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                onPressed: () async {
                  uploadBankDetails();
                  Navigator.pop(context);
                  // await collectionReference
                  //     .doc(collectionReference.doc('Bank details').id)
                  //     .set({
                  //   'Bank name': bankName.text,
                  //   'Account holder': accountHolder.text,
                  //   'Account type': accountType.text,
                  //   'Branch code': branchCode.text,
                  //   'Account number': accountNumber.text,
                  // });
                }),
          ],
        ),
      ),
    ));
  }
}
