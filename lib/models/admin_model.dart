// admin_model.dart

class Admin {
  late int id;
  late String adminName;
  late String department;
  late String adminID;
  late String phoneNo;
  late String profilePicPath;

  Admin({
    required this.adminName,
    required this.department,
    required this.adminID,
    required this.phoneNo,
    required this.profilePicPath,
    required id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adminName': adminName,
      'department': department,
      'adminID': adminID,
      'phoneNo': phoneNo,
      'profilePicPath': profilePicPath,
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      adminName: map['adminName'],
      department: map['department'],
      adminID: map['adminID'],
      phoneNo: map['phoneNo'],
      profilePicPath: map['profilePicPath'],
    );
  }
}
