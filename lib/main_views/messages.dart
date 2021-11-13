import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesScreen extends StatefulWidget {
  @override
  MessagesScreenState createState() => MessagesScreenState();
}


var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600);


class MessagesScreenState extends State<MessagesScreen> {
  String errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> db;

   @override
  void initState() {
    super.initState();
    uid = _auth.currentUser!.uid;
    db = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Messages')
        .doc('Message')
        .snapshots();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 30,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(1, 67, 55, 1),
          toolbarHeight: 100,
          title: new Text(
            'Messages',
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
            child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 30,
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
                          return Text(data['Status'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ));
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Loan amount'),
                      SizedBox(
                        width: 30,
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
                          return Text(data['Loan amount']);
                        },
                      )
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Loan date'),
                      SizedBox(
                        width: 30,
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
                          return Text(data['Loan date']);
                        },
                      )
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Interest'),
                      SizedBox(
                        width: 30,
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
                          return Text(data['Interest']);
                        },
                      )
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Penalty'),
                      SizedBox(
                        width: 30,
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
                          return Text(data['Penalty']);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
