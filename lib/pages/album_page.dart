import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_wall/components/album.dart';
import 'package:social_wall/pages/home_page.dart';

import '../models/album_provider.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    var albumProvider = Provider.of<AlbumProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Album Wall"),
        backgroundColor: Color.fromARGB(255, 252, 202, 0),
        actions: [
          IconButton(
              onPressed: FirebaseAuth.instance.signOut,
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: albumProvider.getJson(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else if (snapshot.data!.runtimeType == Future<dynamic>) {
            return Center(child: Text('Future bop ketip jatyr'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              padding: EdgeInsets.all(20),
              itemCount: snapshot.data![0].length,
              itemBuilder: (context, index) {
                Map<String, dynamic> albumMap = snapshot.data![0][index];
                List<Map<String, dynamic>> photoList = snapshot.data![1];
                return Album(
                  map: albumMap,
                  photos: photoList,
                );
              },
            );
          }
        },
      ),
    );
  }
}
