import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

import 'create_election.dart';
import 'manage_candidate.dart';
import 'show_election.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String adminName = "";
  String department = "";
  String adminID = "";
  String phoneNo = "";
  File? profilePic;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      adminName = prefs.getString('adminName') ?? '';
      department = prefs.getString('department') ?? '';
      adminID = prefs.getString('adminID') ?? '';
      phoneNo = prefs.getString('phoneNo') ?? '';
      String profilePicPath = prefs.getString('profilePicPath') ?? '';
      profilePic = profilePicPath.isNotEmpty ? File(profilePicPath) : null;
    });
  }

  Future<void> _saveUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('adminName', adminName);
    prefs.setString('department', department);
    prefs.setString('adminID', adminID);
    prefs.setString('phoneNo', phoneNo);
    prefs.setString('profilePicPath', profilePic?.path ?? '');
    print('User profile saved to SharedPreferences');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        backgroundColor: Colors.green.shade600,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade600,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: profilePic != null
                        ? Image.file(profilePic!).image
                        : AssetImage('assets/default_profile_pic.jpg'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    adminName.isNotEmpty ? adminName : 'Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                  'Department: ${department.isNotEmpty ? department : 'N/A'}'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Admin ID: ${adminID.isNotEmpty ? adminID : 'N/A'}'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:
                  Text('Phone Number: ${phoneNo.isNotEmpty ? phoneNo : 'N/A'}'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.pop(context);
                _showEditProfileDialog();
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                await _saveUserProfile(); // Save the profile before logging out
                // Handle logout button click
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildCard("Create Election", () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateElectionScreen()));
          }),
          buildCard("Show Elections", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShowElectionsScreen()));
          }),
          buildCard("Manage Candidates", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ManageCandidate()));
          }),
          buildCard("Check Results", () {}),
        ],
      ),
    );
  }

  Widget buildCard(String title, VoidCallback onPressed) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: Text('Go'),
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: InputDecoration(labelText: 'Name'),
                  initialValue: adminName,
                  onChanged: (value) {
                    setState(() {
                      adminName = value!;
                    });
                  },
                ),
                FormBuilderTextField(
                  name: 'department',
                  decoration: InputDecoration(labelText: 'Department'),
                  initialValue: department,
                  onChanged: (value) {
                    setState(() {
                      department = value!;
                    });
                  },
                ),
                FormBuilderTextField(
                  name: 'adminID',
                  decoration: InputDecoration(labelText: 'Admin ID'),
                  initialValue: adminID,
                  onChanged: (value) {
                    setState(() {
                      adminID = value!;
                    });
                  },
                ),
                FormBuilderTextField(
                  name: 'phoneNo',
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  initialValue: phoneNo,
                  onChanged: (value) {
                    setState(() {
                      phoneNo = value!;
                    });
                  },
                ),
                FormBuilderImagePicker(
                  name: 'profilePic',
                  decoration: InputDecoration(labelText: 'Profile Picture'),
                  onChanged: (value) {
                    // Handle image picked
                    // The selected image will be available in the 'value' parameter
                    profilePic = value as File?;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Handle save button click
                // Save data to the database
                await _saveUserProfile();
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showImagePickerDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Profile Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Take a picture'),
                  onTap: () {
                    // Handle camera option
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Choose from gallery'),
                  onTap: () {
                    // Handle gallery option
                    _pickImageFromGallery();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    // Implement image picking from the gallery
    // You can use packages like image_picker
    // Here, I'm using a placeholder function
  }
}
