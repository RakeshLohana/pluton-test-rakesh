
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../Model/ApiModel.dart';
import 'package:test_project/constants/api_contstants.dart';

class ApiService{

 static final dio = Dio();


 static Future<ApiModel?> fetchPosts({required int skip, required int limit}) async {
   try {
     final response = await dio.get(ApiConstants.baseUrl + ApiConstants.getPosts,
      queryParameters: {'limit': limit, 'skip': skip},

 );

     if (response.statusCode == 200) {
         return ApiModel.fromJson(response.data);

     }
   } catch (e) {
     throw Exception('Failed to fetch posts: $e');
   }
   return null;
 }



 static Future<Posts> addPost(String title, String body,int userId) async {
   try {

     final response = await dio.post(ApiConstants.baseUrl+ApiConstants.addPosts, data: jsonEncode({
     'title': title,
     'userId': userId,
       'body':body
     }),
       options: Options(
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
       ),
     );

     if (response.statusCode == 201) {
       print('Post added: ${response.data}');
       return Posts.fromJson(response.data);
     } else {
       throw Exception('Failed to add post');
     }
   } catch (e) {
     throw Exception('Failed to add post: $e');
   }
 }



 static Future<Posts> updatePost(int id, String title, String body) async {
   print('Updating post with ID: ${id}');

   try {
     final response = await dio.put('${ApiConstants.baseUrl+ApiConstants.getPosts}/${id}',
       data: jsonEncode({
         'title': title,
         'body': body,
         'userId': 5,

       }),
       options: Options(
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
       ),
     );

     if (response.statusCode == 200) {
       return Posts.fromJson(response.data);
     } else {
       throw Exception('Failed to update post: ${response.data}');
     }
   } catch (e) {
     throw Exception('Failed to update post: $e');
   }
 }

 // Delete a post
 static Future<bool> deletePost(int id) async {
   try {
     final response = await dio.delete('${ApiConstants.baseUrl+ApiConstants.getPosts}/${id}');

     if (response.statusCode == 200) {
       log('Post deleted successfully');
       return true;
     } else {
       return false;

       throw Exception('Failed to delete post: ${response.data}');
     }
   } catch (e) {
     return false;

     throw Exception('Failed to delete post: $e');
   }
 }
}