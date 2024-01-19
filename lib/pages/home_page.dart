import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_wall/components/drawer.dart';
import 'package:social_wall/components/text_templ.dart';
import 'package:social_wall/components/text_field.dart';
import 'package:social_wall/helper/date.dart';
import 'package:social_wall/pages/album_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<List<List<Map<String, dynamic>>>> fetchPostData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    final commentResponse = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

    if (response.statusCode == 200 || commentResponse.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<dynamic> decodedData1 = json.decode(commentResponse.body);
      final List<Map<String, dynamic>> dataComment =
          List<Map<String, dynamic>>.from(decodedData1);
      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(decodedData);
      return [data, dataComment];
    } else {
      throw Exception('Failed to load data');
    }
  }

  void goToAlbumPage() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/album_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Social Wall"),
        backgroundColor: Color.fromARGB(255, 252, 202, 0),
        actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
      ),
      drawer: MyDrawer(
        onProfileTap: goToAlbumPage,
        onSignOut: signOut,
      ),
      body: Center(
        child: FutureBuilder<List<List<Map<String, dynamic>>>>(
          future: fetchPostData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available.'));
            } else {
              final List<Map<String, dynamic>> data = snapshot.data![0];
              final List<Map<String, dynamic>> commentData = snapshot.data![1];
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  final comment = commentData;
                  return _buildListItem(item, comment);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListItem(
      Map<String, dynamic> item, List<Map<String, dynamic>> comment) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: TextTempl(
                text: 'Post:',
                fontsize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 252, 202, 0)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['title'] ?? 'No title'),
          ),
          ElevatedButton(
            onPressed: () {
              postDetail(item, comment);
            },
            child: Text(
              'View More',
              style: TextStyle(color: Color.fromARGB(255, 252, 202, 0)),
            ),
          ),
        ],
      ),
    );
  }

  postDetail(Map<String, dynamic> item, List<Map<String, dynamic>> comment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Post Details',
            style: TextStyle(
              color: Color.fromARGB(255, 252, 202, 0),
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item['title']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('Body: ${item['body']}'),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Coments',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 252, 202, 0),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: ListView.builder(
                  itemCount: comment.length,
                  itemBuilder: (condex, index) {
                    return comment[index]['postId'] == item['id']
                        ? comContainer(comment[index])
                        : SizedBox();
                  },
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close',
                  style: TextStyle(color: Color.fromARGB(255, 252, 202, 0))),
            ),
          ],
        );
      },
    );
  }

  Widget comContainer(Map<String, dynamic> comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment['body'],
                style: TextStyle(fontSize: 8),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Name: ${comment['name']}',
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                comment['email'],
                style: TextStyle(
                    fontSize: 8,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
