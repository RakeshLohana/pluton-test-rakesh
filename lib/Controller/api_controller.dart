import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:test_project/Service/api_service.dart';

import '../Model/ApiModel.dart';


class ApiController extends GetxController{
    RxList<Posts> postList=<Posts>[].obs;

  int _currentPage = 0; // Start at page 0
  final int _limit = 10;
 RxBool isLoading=false.obs;
 RxBool hasMore=true.obs;


 setLoading(bool value){
   isLoading.value=value;

 }



  Future<void> fetchPosts() async{

    try{
      setLoading(true);
      ApiModel? data =await  ApiService.fetchPosts(limit:_limit ,skip: _currentPage*_limit);
        print(data?.posts??[]);
        postList.addAll(data?.posts??[]);
        _currentPage++;


    } catch(e){
      log(e.toString());
    } finally{
      setLoading(false);

    }
  }


    Future<void> addPost(String title, String body,int userId) async {
      try {
        setLoading(true);
        Posts newPost = await ApiService.addPost(title, body,userId);
        print(newPost.id.toString());
        if(newPost.id!=null) {
          log(newPost.toString());
          postList.insert(0, newPost);
          Get.back(); // Go back to the previous screen

          Get.snackbar('Success', 'Post Added Successfully',
              snackPosition: SnackPosition.BOTTOM);
          setLoading(false);

        }

      } catch (e) {
        print('Error adding post: $e');

      }finally{
        setLoading(false);

      }
    }


    Future<void> updatePost(int id, String title, String body) async {
      try {
        setLoading(true);
        Posts updatedPost = await ApiService.updatePost(id, title, body);

        if (updatedPost.body != null) {
          log(updatedPost.toJson().toString());

          int index = postList.indexWhere((post) => post.id == updatedPost.id);
          if (index != -1) {
            postList[index] = updatedPost;
            Get.back();
            Get.snackbar('Success', 'Post Updated Successfully',
                snackPosition: SnackPosition.BOTTOM);
            setLoading(false);

          }


        }

      } catch (e) {
        print('Error updating post: $e');

      } finally {
        setLoading(false);
      }
    }


    Future<void> deletePost(int id) async {
      try {
        setLoading(true);
        bool success = await ApiService.deletePost(id);
        if (success) {
          postList.removeWhere((post) => post.id == id);
          Get.snackbar('Success', 'Post Deleted Successfully',
              snackPosition: SnackPosition.BOTTOM);
          setLoading(false);

        }

      } catch (e) {
        log('Error deleting post: $e');

      } finally {
        setLoading(false);
      }
    }


}