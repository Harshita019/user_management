import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_management/screens/add_user_screen.dart';
import 'package:user_management/screens/edit_user_screen.dart';
import 'package:user_management/screens/user_list_screen.dart';
import 'package:user_management/model/user_model.dart';
import 'package:user_management/screens/view_user.dart';
import 'package:user_management/controller/user_controller.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
  Get.put(UserController());
  runApp(GetMaterialApp(
  initialRoute: '/',
  getPages: [
    GetPage(name: '/', page: () => UserListScreen()),
    GetPage(name: '/addUser', page: () => AddUserScreen()),
    GetPage(name: '/viewUser', page: () => ViewUserScreen()),
    GetPage(name: '/editUser', page: () => EditUserScreen()), 
  ],
));

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "User Management App",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => UserListScreen()), 
        GetPage(name: '/addUser', page: () => AddUserScreen()), 
        GetPage(name: '/viewUser', page: () => UserListScreen()), 
      ],
    );
  }
}
