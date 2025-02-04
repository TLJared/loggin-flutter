import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggin/controller/Post_controller.dart';

class PostDListView extends StatelessWidget {
  final postController = Get.put(PostController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  PostDListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Posts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: bodyController,
                  decoration: InputDecoration(labelText: 'Cuerpo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    postController.addPost(
                        titleController.text, bodyController.text);
                  },
                  child: Text('Agregar Post'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              titleController.text = post.title;
                              bodyController.text = post.body;
                              postController.updatePost(post.id,
                                  titleController.text, bodyController.text);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => postController.deletePost(post.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
