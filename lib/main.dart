import 'package:flutter/material.dart';
import 'package:voting_app/phone.dart';
import 'package:voting_app/verify.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify()
    },
  ));
}



/*void main() {
  runApp(MaterialApp(
    initialRoute: 'admin',
    //initialRoute: 'Candidates',
    debugShowCheckedModeBanner: false,
    routes: {
      'admin': (context) => AdminScreen(),
      // 'Candidates': (context) => CandidatesScreen(),
    },
  ));
}*/
