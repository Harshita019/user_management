import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:user_management/model/user_model.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  Box<User>? userBox;

  @override
  void onInit() async {
    super.onInit();
    
    try {
      // Initialize Hive
      userBox = await Hive.openBox<User>('users');
      loadUsers();
    } catch (e) {
      print("$e");
    }
  }

  void loadUsers() {
    if (userBox == null) {
    
      return;
    }

    users.assignAll(userBox!.values.toList());
  }

  void addUser(User user) {
    if (userBox != null) {
      userBox!.add(user);
      loadUsers();
    }
  }

  void updateUser(int index, User updatedUser) {
    if (userBox != null) {
      userBox!.putAt(index, updatedUser);
      loadUsers();
    }
  }

  void deleteUser(int index) {
    if (userBox != null) {
      userBox!.deleteAt(index);
      loadUsers();
    }
  }
}
