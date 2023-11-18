import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/follow.dart';

class FollowingScreenController extends GetxController {
  final RxList<Follow> following = <Follow>[].obs;

  @override
  void onInit() {
    super.onInit();
    setFollowing();
  }

  Future<void> setFollowing() async {
    final Uri url = Uri.parse(
        'https://instagram-data1.p.rapidapi.com/followings?username=instagram');
    final Map<String, String> headers = {
      'X-RapidAPI-Key': 'ad15b089admshadc63af00899bedp141008jsn441e9b1514c2',
      'X-RapidAPI-Host': 'instagram-data1.p.rapidapi.com'
    };

    try {
      final http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> collectorList = responseBody['collector'];
        final List<Follow> collectors = collectorList
            .map((collectorData) => Follow.fromJson(collectorData))
            .toList();

        following.addAll(collectors);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
