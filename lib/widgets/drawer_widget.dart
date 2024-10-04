import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:test_project/Controller/auth_controller.dart';

import '../View/add_post_view.dart';
import '../View/favourite_view.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade100),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(authController.firebaseUser.value?.photoURL??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_3BNZw4G45qsnyRTopol8ESLnkfejmN_WcA&s"),
                  ),
                ),
                Gap( 5),
                Text(
                  authController.firebaseUser.value?.displayName??'',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  authController.firebaseUser.value?.email??'',
                  style: TextStyle(
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading:Icon( CupertinoIcons.home),
            title: Text('Home'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading:Icon( CupertinoIcons.add),
            title: Text('Add Post'),
            onTap: () {
              Get.back();
              Get.to(AddPostView());
            },
          ),

          ListTile(
            leading:Icon( CupertinoIcons.heart_fill,),
            title: Text('Favourites'),
            onTap: () {
              Get.back();
              Get.to(FavoritePostsView());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              authController.signOut();

            },
          ),
        ],
      ),
    );
  }
}
