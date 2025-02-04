import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:loggin/models/model_place.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <Post>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        postList.value = jsonData.map((post) => Post.fromJson(post)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los datos');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addPost(String title, String body) async {
    try {
      var response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: json.encode({"title": title, "body": body, "userId": 1}),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 201) {
        var jsonResponse = json.decode(response.body);
        postList.add(Post.fromJson(jsonResponse));
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo agregar el post');
    }
  }

  Future<void> deletePost(int id) async {
    try {
      var response = await http
          .delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/\$id'));
      if (response.statusCode == 200) {
        postList.removeWhere((post) => post.id == id);
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo eliminar el post');
    }
  }

  Future<void> updatePost(int id, String body, String title) async {
    try {
      var response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/\$id'),
        body: json.encode({"title": title, "body": body, "userId": 1}),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var index = postList.indexWhere((post) => post.id == id);
        if (index != -1) {
          postList[index] = Post.fromJson(jsonResponse);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Nose puedo actualizar');
    }
  }
}
