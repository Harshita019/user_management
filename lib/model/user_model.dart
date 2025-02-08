import 'package:hive/hive.dart';
part 'user_model.g.dart'; 

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String gender;

  @HiveField(3)
  String dob;

  @HiveField(4)
  String pincode;

  @HiveField(5)
  String state;

  @HiveField(6)
  String address;

  @HiveField(7)
  String jobTitle;

  @HiveField(8)
  String companyName;

  @HiveField(9)
  String workExperience;

  User({
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    required this.pincode,
    required this.state,
    required this.address,
    required this.jobTitle,
    required this.companyName,
    required this.workExperience,
  });
}
