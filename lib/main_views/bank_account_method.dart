import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BankAccountMethod extends StatefulWidget {
  const BankAccountMethod({Key? key}) : super(key: key);

  @override
  _BankAccountMethodState createState() => _BankAccountMethodState();
}

class _BankAccountMethodState extends State<BankAccountMethod> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountHolder = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final TextEditingController branchCode = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();

  final Stream<DocumentSnapshot<Map<String, dynamic>>> db = FirebaseFirestore
      .instance
      .collection('users')
      .doc('Bank details')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/accountMethod');
          },
        ),
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 100,
        centerTitle: true,
        title: new Text(
          'Bank account details',
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
                          StreamBuilder<DocumentSnapshot>(
                            stream: db,
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError)
                                return Text('Something went wrong');
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return CircularProgressIndicator();

                              dynamic data = snapshot.data!.data();
                              return TextField(
                                controller: bankName,
                                decoration: InputDecoration(
                                  labelText: (data['Bank name']),
                                  border: UnderlineInputBorder(),
                                ),
                              );

                              // return Text(data['Amount due']);
                            },
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: db,
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError)
                                return Text('Something went wrong');
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return CircularProgressIndicator();

                              dynamic data = snapshot.data!.data();
                              return TextField(
                                controller: accountHolder,
                                decoration: InputDecoration(
                                  labelText: (data['Account holder']),
                                  border: UnderlineInputBorder(),
                                ),
                              );

                              // return Text(data['Amount due']);
                            },
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: db,
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError)
                                return Text('Something went wrong');
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return CircularProgressIndicator();

                              dynamic data = snapshot.data!.data();
                              return TextField(
                                controller: accountType,
                                decoration: InputDecoration(
                                  labelText: (data['Account type']),
                                  border: UnderlineInputBorder(),
                                ),
                              );

                              // return Text(data['Amount due']);
                            },
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: db,
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError)
                                return Text('Something went wrong');
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return CircularProgressIndicator();

                              dynamic data = snapshot.data!.data();
                              return TextField(
                                controller: branchCode,
                                decoration: InputDecoration(
                                  labelText: (data['Branch code']),
                                  border: UnderlineInputBorder(),
                                ),
                              );

                              // return Text(data['Amount due']);
                            },
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: db,
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError)
                                return Text('Something went wrong');
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return CircularProgressIndicator();

                              dynamic data = snapshot.data!.data();
                              return TextField(
                                controller: accountNumber,
                                decoration: InputDecoration(
                                  labelText: (data['Account number']),
                                  border: UnderlineInputBorder(),
                                ),
                              );

                              // return Text(data['Amount due']);
                            },
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            ElevatedButton(
                child: Text('Save changes',
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
                  await collectionReference
                      .doc(collectionReference.doc('Bank details').id)
                      .update({
                    'Bank name': bankName.text,
                    'Account holder': accountHolder.text,
                    'Account type': accountType.text,
                    'Branch code': branchCode.text,
                    'Account number': accountNumber.text,
                  });
                  Navigator.of(context).pushReplacementNamed('/home');
                }),
          ],
        ),
      ),
    );
  }
}
