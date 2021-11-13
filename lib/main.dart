import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/main_views/account_method.dart';
import 'package:flutter_application_1/main_views/home_with_bottom_navbar.dart';
import 'package:flutter_application_1/registration/get_started.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main_views/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 // print('current ser ${FirebaseAuth.instance.currentUser}');
  runApp(MyApp());
}

// final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //initialRoute: '/home',
      title: 'Cashful',
      home:
      //FirebaseAuth.instance.currentUser != null ? MyHomePage() :  LoginScreen(),

      StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return LoginScreen();
            } else {
              return HomeWithBottomNavBar();
            }
          } else {
            return LoginScreen();
          }
        },
      ),


      routes: {
        '/home': (context) => HomeWithBottomNavBar(),
        '/signIn': (context) => LoginScreen(),
        '/settings': (context) => SettingsPage(),
        '/accountMethod': (context) => AccountMethod(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'An email address is required';
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid email address format';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'A password is required';
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
  Password must be at least 8 characters, 
  include an uppercase letter, number and symbol
  ''';
  return null;
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _MyHomePageState extends State<MyHomePage> {
  void createUID() async {
    FirebaseFirestore.instance.collection('users').doc(uid).set({});
    // .collection('Profile')
    // .doc('Applications')
    // .set({});
  }

  String errorMessage = '';
  bool _obscureText = true;
  User? newuser = FirebaseAuth.instance.currentUser;
  final _key = GlobalKey<FormState>();
  //marks user state as logged in..?

  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        toolbarHeight: 100,
        centerTitle: true,
        title: new Text(
          'Create account',
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
        child: Container(
          padding: EdgeInsets.all(20),
          child: ModalProgressHUD(
            inAsyncCall: showProgress,
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            'Email address',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      email = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(border: UnderlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    validator: validatePassword,
                    obscureText: _obscureText,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      password = value; //get the value entered by user.
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: Colors.grey,
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: UnderlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 1,
                    color: Colors.green[5],
                    borderRadius: BorderRadius.circular(32.0),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                            createUID();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetStartedPage()),
                            );

                            errorMessage = '';
                          } on FirebaseAuthException catch (error) {
                            errorMessage = error.message!;
                          }
                        }
                        setState(() {});
                      },
                      minWidth: 200.0,
                      height: 50.0,
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Already registered? Login now",
                      style: TextStyle(
                          color: Colors.grey[700], fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
