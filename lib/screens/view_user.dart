import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/controller/user_controller.dart';
import 'package:user_management/model/user_model.dart';
import 'edit_user_screen.dart'; 

class ViewUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Get.arguments;
    final UserController userController = Get.find<UserController>();

    if (userData == null || userData["user"] == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child:  Text("User data is missing!")),
      );
    }

    final User user = userData["user"];
    final int userIndex = userData["index"]; 

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.32,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.lightBlue.shade300)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userDetailRow("Name -", user.name),
                  userDetailRow("Email -", user.email),
                  userDetailRow("Gender -", user.gender),
                  userDetailRow("DOB -", user.dob),
                  userDetailRow("Address -", user.address),
                  userDetailRow("Pin Code. -", user.pincode),
                  userDetailRow("State", user.state),
                  userDetailRow("JobTitle -", user.jobTitle),
                  userDetailRow("Company -", user.companyName),
                  userDetailRow("Experience -", user.workExperience),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Row(
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.red, size: 28),
                            SizedBox(width: 10),
                            Text("Delete User",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        content: const Text(
                          "Are you sure you want to delete this user?",
                          style: TextStyle(fontSize: 16),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () => Get.back(),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            onPressed: () {
                              userController.deleteUser(userIndex);
                              Get.back();
                              Get.back();
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Delete User'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.lightBlue.shade300),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: () {
                    Get.to(() => EditUserScreen(),
                        arguments: {"user": user, "index": userIndex});
                  },
                  child: const Text(
                    'Edit Details',
                    style: TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row userDetailRow(String title, String content) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            content,
            style: const TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

}
