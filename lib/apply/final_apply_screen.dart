import 'package:flutter/material.dart';

class FinalApplyScreen extends StatefulWidget {
  const FinalApplyScreen({Key? key}) : super(key: key);

  @override
  _FinalApplyScreenState createState() => _FinalApplyScreenState();
}

class _FinalApplyScreenState extends State<FinalApplyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apply')),
      body: Center(child: Container(child: Text('final screen')))
    );
  }
}
