import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathermobileapp/models/location_model.dart';
import '../models/current_weather_model.dart';
import '../models/forecast_day_model.dart';
import '../models/history_weather_model.dart';
import '../services/weather_api_services.dart';


  final weatherServiceProvider = Provider<WeatherApiServices>((ref) {//here ref means i could access this function as instances
    return WeatherApiServices();
  });

  //current forecast

  final currentWeatherProvider = FutureProvider.family<CurrentWeatherModel, String>((ref, location) async {//use family to pass the location as a parameter(don't need family if you don't pass any parameter)
    final service = ref.read(weatherServiceProvider);
    final data = await service.getHourlyForecast(location);
    return CurrentWeatherModel.fromJson(data);
  });

  //hourly forecast

  final next7DaysProvider = FutureProvider.family<ForecastDayModel, String>((ref, location,) async { // here FuturePovider cause it returns a future type
    final service = ref.read(weatherServiceProvider);
    final data = await service.getHourlyForecast(location);
    return ForecastDayModel.fromJson(data);
  });

  //past 7 days forecast

  final past7daysProvider = FutureProvider.family<List<HistoryWeatherModel>,String>((ref, location)async{
    final service  = ref.read(weatherServiceProvider);
    final dataList = await service.getLast7DaysForecast(location);
    return dataList.map((e) => HistoryWeatherModel.fromJson(e)).toList();
  });

  final locationProvider = FutureProvider.family<LocationModel, String>((ref, location) async {//use family to pass the location as a parameter(don't need family if you don't pass any parameter)
    final service = ref.read(weatherServiceProvider);
    final data = await service.getHourlyForecast(location);
    return LocationModel.fromJson(data);
  });