import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String apiKey = "661efa7a9ace43668ce23417250311";
final String _baseUrl = "http://api.weatherapi.com/v1";

class WeatherApiServices {
  //current+next 7 days forecast
  Future<Map<String, dynamic>> getHourlyForecast(String location) async {
    final url = Uri.parse(
      "$_baseUrl/forecast.json?key=$apiKey&q=$location&days=7",
    );
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("Failed to fetch data : ${res.body}");
    }
    final data = json.decode(res.body);

    if (data.containsKey(
        'error')) {   //containsKey is like a query searching for word error in map
      throw Exception(data['error']['message'] ?? 'Invalid location');
    }
    return data;
  }

  //weather history of past 7 days


  Future<List<Map<String, dynamic>>> getLast7DaysForecast(String location) async {
    final List<Map<String, dynamic>> historyWeather = [];
    final today = DateTime.now();
    for(int i=1; i<=7; i++){
      final date = today.subtract(Duration(days: i));
      final formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      final url = Uri.parse("$_baseUrl/history.json?key=$apiKey&q=$location&dt=$formattedDate");
      final res = await http.get(url);
      if(res.statusCode != 200){
        throw Exception("Failed to fetch data : ${res.body}");
      }
      final data = json.decode(res.body);
      if(data.containsKey('error')){
        throw Exception(data['error']['message'] ?? 'Invalid location');
      }
      if(data['forecast']?['forecastday']!=null){
        historyWeather.add(data);
      }else{
        debugPrint("No forecast found for $formattedDate : ${res.body}");
      }
    }
    return historyWeather;
  }
}
