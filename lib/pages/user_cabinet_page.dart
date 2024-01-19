import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_wall/components/text_templ.dart';

class UserCabinetPage extends StatefulWidget {
  const UserCabinetPage({super.key});

  @override
  State<UserCabinetPage> createState() => _UserCabinetPageState();
}

class _UserCabinetPageState extends State<UserCabinetPage> {
  Map<String, dynamic> map = {};
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
      map = args as Map<String, dynamic>;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(map['username']),
        backgroundColor: Color.fromARGB(255, 252, 202, 0),
        actions: [
          IconButton(
              onPressed: FirebaseAuth.instance.signOut,
              icon: Icon(Icons.logout))
        ],
      ),
      body: Card(
        elevation: 10,
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: CircleAvatar(
                radius: 51,
                backgroundImage: AssetImage('lib/assets/images/icon.png'),
              ),
            ),
            Center(
              child: TextTempl(
                  text: '${map['name']} ● ${map['username']}',
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Center(
              child: TextTempl(
                  text: map['email'],
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            PersonalData(),
            PersonalGeoData(),
          ],
        ),
      ),
    );
  }

// "phone": "1-770-736-8031 x56442",
// "website": "hildegard.org",
// "company": {
// "name": "Romaguera-Crona",
// "catchPhrase": "Multi-layered client-server neural-net",
// "bs": "harness real-time e-markets"
// }
  Widget PersonalData() {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          const TextTempl(
              text: 'Contacts',
              fontsize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          TextTempl(
              text: 'Phone: ${map['phone']}',
              fontsize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          TextTempl(
              text: 'Website: ${map['website']}',
              fontsize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          const SizedBox(
            height: 8,
          ),
          const TextTempl(
              text: 'Job',
              fontsize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          TextTempl(
              text: 'Company name: ${map['company']['name']}',
              fontsize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          TextTempl(
              text: '"${map['company']['catchPhrase']}"',
              fontsize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ],
      ),
    );
  }

  Widget PersonalGeoData() {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          const TextTempl(
              text: 'Address',
              fontsize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          TextTempl(
              text: 'Street: ${map['address']['street']}',
              fontsize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          TextTempl(
              text: 'Suite: ${map['address']['suite']}',
              fontsize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          TextTempl(
              text: 'City: ${map['address']['city']}',
              fontsize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black),
          TextTempl(
              text: 'Zip-code: ${map['address']['zipcode']}',
              fontsize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ],
      ),
    );
  }
}
