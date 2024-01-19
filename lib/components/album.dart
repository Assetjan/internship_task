import 'package:flutter/material.dart';
import 'package:social_wall/components/button.dart';
import 'package:social_wall/components/text_templ.dart';

class Album extends StatelessWidget {
  final Map<String, dynamic> map;
  final List<Map<String, dynamic>> photos;
  const Album({super.key, required this.map, required this.photos});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPhotos =
        photos.where((photo) => photo['albumId'] == map['id']).toList();
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/each_album_page',
            arguments: [map['title'], filteredPhotos]);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 252, 202, 0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextTempl(
                text: map['title'],
                fontsize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Image.network(
                      filteredPhotos[index]['thumbnailUrl'],
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Text("Image failed to load");
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
