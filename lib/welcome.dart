import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggin/controller/Post_controller.dart';
import 'package:loggin/delete.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Posts')),
      body: Obx(() {
        if (postController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: postController.postList.length,
          itemBuilder: (context, index) {
            var post = postController.postList[index];
            return Card(
              child: ListTile(
                title: Text(post.title,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(post.body),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to((PostDListView()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
