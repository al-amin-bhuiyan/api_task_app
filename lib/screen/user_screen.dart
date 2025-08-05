// screen/user_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';

class UserScreen extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.users.isEmpty) {
          return Center(child: Text('No users found.'));
        }
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          },
        );
      }),
    );
  }
}
