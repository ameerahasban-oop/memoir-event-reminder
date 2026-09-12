import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {

  static const String url =
      'https://script.google.com/macros/s/AKfycbwM3edeMlL-fHLHOScncVQjTlAjPR28LALoUWMbxc-VAUj27b8nbVxpmPCOVoW8K57_zg/exec';

  static Future<bool> addReview({
    required String review,
    required String rating,
  }) async {

    try {

      final prefs =
      await SharedPreferences.getInstance();

      String username =
          prefs.getString('currentUser') ??
              "Unknown User";

      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': username,
          'rating': rating,
          'review': review,
        },
      );

      return response.statusCode == 200;

    } catch (e) {

      print(e);
      return false;

    }
  }

  static Future<List<dynamic>> getReviews() async {

    try {

      final response =
      await http.get(Uri.parse(url));

      return jsonDecode(response.body);

    } catch (e) {

      print(e);
      return [];

    }
  }
}