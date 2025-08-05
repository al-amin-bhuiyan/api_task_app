import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {

    fetchUsers();
    super.onInit();
  }

  void fetchUsers({int page = 1}) async {
    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users?page=$page'),
        headers: {
          'x-api-key': 'reqres-free-v1',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<User> fetchedUsers = data.map((e) => User.fromJson(e)).toList();

        users.assignAll(fetchedUsers);

        final box = Hive.box<User>('userBox');
        await box.clear(); // clear old data
        for (var user in fetchedUsers) {
          await box.add(user);
        }
      } else {
        print("Failed to load users. Status: ${response.statusCode}");
        loadOfflineData();
      }
    } catch (e) {
      print("Error: $e");
      loadOfflineData(); // if no internet
    } finally {
      isLoading(false);
    }
  }

  void loadOfflineData() {
    final box = Hive.box<User>('userBox');
    final offlineUsers = box.values.toList();
    users.assignAll(offlineUsers);
  }
}
