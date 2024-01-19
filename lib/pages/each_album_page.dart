import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/text_templ.dart';

class EachAlbumPage extends StatefulWidget {
  const EachAlbumPage({super.key});

  @override
  State<EachAlbumPage> createState() => _EachAlbumPageState();
}

class _EachAlbumPageState extends State<EachAlbumPage> {
  String title = '';
  List<Map<String, dynamic>> filteredPhotos = [];
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      List<dynamic> args = settings.arguments as List<dynamic>;
      title = args[0] as String;
      filteredPhotos = args[1] as List<Map<String, dynamic>>;
    }
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
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextTempl(
              text: title,
              fontsize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 252, 202, 0),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: filteredPhotos.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    filteredPhotos[index]['url'],
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Text("Image failed to load");
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
