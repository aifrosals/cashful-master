import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/registration/add_bank_account.dart';

class VerificationPage4 extends StatefulWidget {
  const VerificationPage4(BuildContext context, {Key? key}) : super(key: key);

  @override
  _VerificationPage4State createState() => _VerificationPage4State();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _VerificationPage4State extends State<VerificationPage4> {
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController registeredNames = TextEditingController();

  void uploadMTNAccountDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Profile')
        .doc('MTN account details')
        .set({
      'Savings p/m': registeredNames.text,
      'Stokvel participation?': mobileNumber.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        toolbarHeight: 100,
        centerTitle: true,
        title: new Text(
          'Payment',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(children: [
          SizedBox(height: 20),
          Text('Setup an account to which funds will be deposited and paid',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    AlertDialog dialog = AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Container(
                          height: 200,
                          width: 200,
                          child: Form(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Add MTN account',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  SizedBox(height: 15),
                                  TextField(
                                    controller: registeredNames,
                                    decoration: InputDecoration(
                                      labelText: 'Registered Names',
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextField(
                                    controller: mobileNumber,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile Number',
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        actions: [
                          Container(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(1, 67, 55, 1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                child: Text('Finish'),
                                onPressed: () async {
                                  uploadMTNAccountDetails();
                                  Navigator.pop(context);
                                }),
                          )
                        ]);
                    return dialog;
                  });
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  child: Image(image: AssetImage('assets/images/mtn.png'))),
              SizedBox(
                width: 25,
              ),
              Container(child: Text('MTN Mobile Money'))
            ]),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBankAccountScreen()));
            },
            child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 93),
                      child: Image(
                          image: AssetImage('assets/images/stdbank.png'))),
                  SizedBox(
                    width: 35,
                  ),
                  Container(child: Text('EFT Transfer')),
                ]),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
              'Please ensure you only add a South African account that is in your own name',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          SizedBox(height: 40),
          ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(1, 67, 55, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                      ),
                      child: Text('Complete registration'),
                      onPressed: ()  {
                       Navigator.of(context).pushReplacementNamed('/home');
                      }),
        ]),
      )),
    );
  }
}

