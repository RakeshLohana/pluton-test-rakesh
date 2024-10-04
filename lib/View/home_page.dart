


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:test_project/Controller/api_controller.dart';
import 'package:test_project/Controller/auth_controller.dart';
import 'package:test_project/Controller/favourite_controller.dart';
import 'package:test_project/Model/ApiModel.dart';
import 'package:test_project/View/add_post_view.dart';
import 'package:test_project/View/favourite_view.dart';
import 'package:test_project/View/update_view.dart';

import '../widgets/drawer_widget.dart'; // Import the update post view

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApiController apiController;
  late FavoriteController favoriteController;
  late AuthController authController;

  @override
  void initState() {
    apiController = Get.put(ApiController());
    favoriteController = Get.put(FavoriteController());
    authController = Get.find();

    Future.microtask(() => apiController.fetchPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

       Scaffold(
       drawer: DrawerWidget(authController: authController),

       appBar: AppBar(
         centerTitle: true,
         title: Text('Home Screen'),

         actions: [
           IconButton(
             icon: Icon(Icons.add),
             onPressed: () {
               Get.to(() => AddPostView());
             },
           ),
           IconButton(
             icon: Icon(Icons.favorite,color: Colors.red,),
             onPressed: () {
               Get.to(() => FavoritePostsView());            },
           ),
         ],
       ),
       body: Obx(() {
         if (apiController.isLoading.value && apiController.postList.isEmpty) {
           return Center(child: CircularProgressIndicator());
         }

         if (apiController.postList.isEmpty) {
           return Center(child: Text('No posts available'));
         }


         return NotificationListener<ScrollNotification>(
           onNotification: (ScrollNotification scrollInfo) {
             if (!apiController.isLoading.value &&
                 scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
               apiController.fetchPosts();
             }
             return false;
           },
           child:ListView.builder(
            itemCount: apiController.postList.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index < apiController.postList.length) {
                final post = apiController.postList[index];
                return CardWidget(post: post,
                  favoriteController: favoriteController,
                  apiController: apiController,
                  isFavourite: false,);
              } else {
                return apiController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox.shrink();
              }
            })

         );
       }),
                 );
  }
}




class CardWidget extends StatelessWidget {
  final Posts post;
  final bool isFavourite;
  final FavoriteController favoriteController;
  final ApiController? apiController;
  const CardWidget({super.key, required this.post, required this.favoriteController,  this.apiController, required this.isFavourite});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey,offset: Offset(0.6, 0.7),blurRadius: 0.7)
          ],
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: Text(post.title ?? "",maxLines: 3,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
              Obx(() {
                bool isFavorite = favoriteController.favoritePosts
                    .any((favPost) => favPost.id == post.id);
                return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        favoriteController.removeFavorite(int.parse(
                            post.id!.toString()));
                      } else {
                        favoriteController.addFavorite(post);

                      }});
              }                ),

              isFavourite==false ? PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    Get.to(() => UpdatePostView(post: post));
                  } else if (value == 'delete') {
                    apiController?.deletePost(int.parse(post.id!.toString()));
                  }
                },
              ):Container(),
            ],
          ),
          Gap(5),

          Text(post.body ?? "",),
          Gap(7),
        !isFavourite?  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.thumb_up_rounded,color: Colors.green,),
                  Gap(5),
                  Text(post.reactions?.likes.toString()??""),
                ],
              ),

              Row(
                children: [
                  Icon(Icons.thumb_down,color: Colors.red,),
                  Gap(5),
                  Text(post.reactions?.dislikes.toString()??""),
                ],
              ),
            ],
          ):Container()

        ],
      ),

    );
  }
}

