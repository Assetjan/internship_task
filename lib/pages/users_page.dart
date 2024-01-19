import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../components/text_templ.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

Future<List<Map<String, dynamic>>> fetchData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    final List<dynamic> decodedData = json.decode(response.body);
    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(decodedData);
    return data;
  } else {
    throw Exception('Failed to load album data');
  }
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        backgroundColor: Color.fromARGB(255, 252, 202, 0),
        actions: [
          IconButton(
              onPressed: FirebaseAuth.instance.signOut,
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/user_cabinet_page',
                      arguments: snapshot.data![index]);
                },
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          size: 20.0,
                          color: Color.fromARGB(255, 252, 202, 0),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTempl(
                                text: '${snapshot.data![index]['name']} ',
                                fontsize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 252, 202, 0)),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
