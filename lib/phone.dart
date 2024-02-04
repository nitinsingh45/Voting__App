import 'package:flutter/material.dart';

import 'package:voting_app/verify.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  String selectedRole = 'Admin'; // Default value
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img1.jpg',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 25),
            Text(
              "Phone Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "We need to register your phone without getting started!",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole = newValue!;
                });
              },
              items: <String>['Admin', 'Voter', 'Candidates']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      controller: countryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Text(
                    "|",
                    style: TextStyle(fontSize: 33, color: Colors.grey),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  String phoneNumber =
                      countryController.text + phoneController.text;
                  if (phoneNumber == "1234567890") {
                    // admin screen
                    // for initial login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyVerify()),
                    );
                  } else if (phoneNumber == "1234567891") {
                    //candidate screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyVerify()),
                    );
                  } else {
                    // Continue with the existing behavior
                    Navigator.pushNamed(context, 'verify');
                  }
                },
                child: Text("Send the code"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
