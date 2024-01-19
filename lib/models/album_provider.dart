import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AlbumProvider extends ChangeNotifier {
  Future<List<Map<String, dynamic>>> fetchAlbumData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(decodedData);
      return data;
    } else {
      throw Exception('Failed to load album data');
    }
  }

  getAlbumData(int index) async {
    final map = await fetchAlbumData();
    return map[index];
  }

  getAlbumDataList() async {
    final List<Map<String, dynamic>> list = await fetchAlbumData();
    return list;
  }

  getJson() async {
    final List<Map<String, dynamic>> listAlbum = await fetchAlbumData();
    final List<Map<String, dynamic>> listPhoto = await fetchPhotoData();
    return [listAlbum, listPhoto];
  }

  Future<List<Map<String, dynamic>>> fetchPhotoData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(decodedData);
      return data;
    } else {
      throw Exception('Failed to load photo data');
    }
  }

  getPhotoData(int index) async {
    final map = await fetchPhotoData();
    return map[index];
  }

  getPhotoDataList() async {
    final List<Map<String, dynamic>> list = await fetchPhotoData();
    return list;
  }
}
