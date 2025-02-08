import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/controller/user_controller.dart';
import 'view_user.dart';

class UserListScreen extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User List")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/addUser'),
        backgroundColor: Colors.lightBlue.shade100,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (userController.users.isEmpty) {
          return const Center(
            child: Text(
              "No users found. Please add a user.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            final user = userController.users[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => ViewUserScreen(),
                    arguments: {"user": user, "index": index});
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.lightBlue.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userDetailRow("Name - ",  user.name),
                          userDetailRow("Email - ",  user.email),
                          userDetailRow("Gender - ",  user.gender),
                          userDetailRow("DOB - ",  user.dob),
                          
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade100,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => ViewUserScreen(),
                            arguments: {"user": user, "index": index});
                      },
                      child: const Text("View"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Row userDetailRow(String title, String content) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
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
