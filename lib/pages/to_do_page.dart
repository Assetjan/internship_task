import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_wall/components/text_templ.dart';
import 'package:http/http.dart' as http;

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

Future<List<Map<String, dynamic>>> fetchData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

  if (response.statusCode == 200) {
    final List<dynamic> decodedData = json.decode(response.body);
    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(decodedData);
    return data;
  } else {
    throw Exception('Failed to load album data');
  }
}

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-do Wall"),
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
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextTempl(
                          text:
                              '${snapshot.data![index]['id']}. ${snapshot.data![index]['title']} ',
                          fontsize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 252, 202, 0)),
                      SizedBox(
                        height: 5,
                      ),
                      snapshot.data![index]['completed'] == true
                          ? Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 0, 255, 0),
                              ),
                              child: TextTempl(
                                  text: "DONE",
                                  fontsize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 128, 0)),
                            )
                          : Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 255, 0, 0),
                              ),
                              child: TextTempl(
                                  text: 'NOT DONE',
                                  fontsize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 128, 0, 0)),
                            )
                    ],
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
