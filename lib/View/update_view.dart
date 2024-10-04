// views/update_post_view.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:test_project/Controller/api_controller.dart';
import 'package:test_project/Model/ApiModel.dart';
import 'package:test_project/widgets/custom_button.dart';
import 'package:test_project/widgets/custom_text_field.dart';

class UpdatePostView extends StatefulWidget {
  final Posts post;

  UpdatePostView({required this.post});

  @override
  State<UpdatePostView> createState() => _UpdatePostViewState();
}



class _UpdatePostViewState extends State<UpdatePostView> {
  final ApiController apiController = Get.find();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
@override
  void initState() {
    super.initState();
    titleController.text=widget.post.title??"";
    bodyController.text=widget.post.body??"";

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
        title: Text('Update Post'),
      ),
      body: SingleChildScrollView(
        child: Obx(()=>
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(

              children: [
                CustomTextField(

                  hint: "",
                  controller: titleController,
                  maxLines: 2,
                ),
                Gap(20),
                CustomTextField(
                  hint: "",
                  controller: bodyController,
                  maxLines: 8,
                ),
                SizedBox(height: 20),
                apiController.isLoading.value?Center(child: CircularProgressIndicator(),):CustomButton(
                  buttonColor: Colors.blue.shade200,
                  text: "Update",
                  onPressed: () {
                    log(widget.post.id.toString());
                    apiController.updatePost(int.parse(widget.post.id!.toString()), titleController.text, bodyController.text);
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
