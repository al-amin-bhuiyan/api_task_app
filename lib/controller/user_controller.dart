import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
          'x-api-key': 'reqres-free-v2',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<User> fetchedUsers = data.map((e) => User.fromJson(e)).toList();
        users.addAll(fetchedUsers); // Add to existing list
      } else {
        print("Failed to load users. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

}
