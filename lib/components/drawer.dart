import 'package:flutter/material.dart';
import 'package:social_wall/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 252, 202, 0),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () => Navigator.pop(context),
              ),
              MyListTile(
                icon: Icons.image,
                text: 'A L B U M S',
                onTap: () {
                  Navigator.pushNamed(context, '/album_page');
                },
              ),
              MyListTile(
                icon: Icons.task_alt,
                text: 'T O D O',
                onTap: () {
                  Navigator.pushNamed(context, '/to_do_page');
                },
              ),
              MyListTile(
                icon: Icons.people_outline,
                text: 'U S E R S',
                onTap: () {
                  Navigator.pushNamed(context, '/users_page');
                },
              ),
            ],
          ),
          MyListTile(icon: Icons.logout, text: 'L O G O U T', onTap: onSignOut),
        ],
      ),
    );
  }
}
