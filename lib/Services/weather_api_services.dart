import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String apiKey = "661efa7a9ace43668ce23417250311";
final String _baseUrl = "http://api.weatherapi.com/v1";

class WeatherApiServices {
  Future<Map<String, dynamic>> getHourlyForecast(String location) async {
    final url = Uri.parse(
      "$_baseUrl/forecast.json?key=$apiKey&q=$location&days=7",
    );
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("Failed to fetch data : ${res.body}");
    }
    final data = json.decode(res.body);

    if(data.containsKey('error')){//containsKey is like a query searching for word error in map
      throw Exception(data['error']['message']??'Invalid location');
    }
    return data;
  }

  //weather history of past 7 days
}
