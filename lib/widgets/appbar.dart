import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      title: Text('Index'),
    
      centerTitle: true,
      leading: IconButton(
        icon: Image.asset("assets/Group 158.png"),
        onPressed: () {},
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/profilePhoto.png'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}