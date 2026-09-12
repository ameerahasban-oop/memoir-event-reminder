import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {

  static const String apiKey =
      "YOUR_OPENWEATHER_API_KEY";

  static Future<String> getWeather(
      String city) async {

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
    );

    final response =
    await http.get(url);

    if (response.statusCode == 200) {

      final data =
      jsonDecode(response.body);

      String weather =
      data["weather"][0]["main"];

      double temp =
      data["main"]["temp"];

      return "$weather\nTemperature: ${temp.toStringAsFixed(1)}°C";
    }

    return "Weather not found";
  }
}