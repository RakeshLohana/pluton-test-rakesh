// views/add_post_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/Controller/api_controller.dart';
import 'package:test_project/widgets/custom_button.dart';
import 'package:test_project/widgets/custom_text_field.dart';

class AddPostView extends StatelessWidget {
  final ApiController apiController = Get.find();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
        title: Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Obx(()=>
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(

              children: [
                CustomTextField(
                  hint: "Title",
                  controller: titleController,
                  keyboardType: TextInputType.text,

                  maxLines: 2,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  hint: "Type Description of post",
                  controller: bodyController,
                  keyboardType: TextInputType.text,

                  maxLines: 4,
                ),
                SizedBox(height: 20),
               apiController.isLoading.value?Center(child: CircularProgressIndicator(),): CustomButton(
                  text:'Add Post' ,
                  buttonColor: Colors.blue.shade200,
                  iconData: Icons.add,
                  onPressed: () {
                    if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty)  {
                     apiController.addPost(titleController.text, bodyController.text,5);

                    } else {
                      Get.snackbar('Error', 'Please fill in all fields',
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
