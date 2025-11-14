//the model returns false type casting so i had to change the whole thing


class HistoryWeatherModel {
  final Forecast? forecast;

  HistoryWeatherModel({this.forecast});

  factory HistoryWeatherModel.fromJson(Map<String, dynamic> json) {
    return HistoryWeatherModel(
      forecast: json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (forecast != null) 'forecast': forecast!.toJson(),
  };
}

class Forecast {
  final List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: json['forecastday'] != null
          ? (json['forecastday'] as List)
          .map((e) => Forecastday.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (forecastday != null)
      'forecastday': forecastday!.map((e) => e.toJson()).toList(),
  };
}

class Forecastday {
  final String? date;
  final int? dateEpoch;
  final Day? day;
  final Astro? astro;
  final List<Hour>? hour;

  Forecastday({this.date, this.dateEpoch, this.day, this.astro, this.hour});

  factory Forecastday.fromJson(Map<String, dynamic> json) {
    return Forecastday(
      date: json['date']?.toString(),
      dateEpoch: json['date_epoch'] is int ? json['date_epoch'] : (json['date_epoch'] as num?)?.toInt(),
      day: json['day'] != null ? Day.fromJson(json['day']) : null,
      astro: json['astro'] != null ? Astro.fromJson(json['astro']) : null,
      hour: json['hour'] != null
          ? (json['hour'] as List).map((e) => Hour.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'date_epoch': dateEpoch,
    if (day != null) 'day': day!.toJson(),
    if (astro != null) 'astro': astro!.toJson(),
    if (hour != null) 'hour': hour!.map((e) => e.toJson()).toList(),
  };
}

class Day {
  final double? maxtempC;
  final double? maxtempF;
  final double? mintempC;
  final double? mintempF;
  final double? avgtempC;
  final double? avgtempF;
  final double? maxwindMph;
  final double? maxwindKph;
  final double? totalprecipMm;
  final double? totalprecipIn;
  final double? totalsnowCm;
  final double? avgvisKm;
  final double? avgvisMiles;
  final int? avghumidity;
  final int? dailyWillItRain;
  final int? dailyChanceOfRain;
  final int? dailyWillItSnow;
  final int? dailyChanceOfSnow;
  final Condition? condition;
  final double? uv;

  Day({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    num? parseNum(dynamic value) => value is num ? value : num.tryParse(value?.toString() ?? '');
    return Day(
      maxtempC: parseNum(json['maxtemp_c'])?.toDouble(),
      maxtempF: parseNum(json['maxtemp_f'])?.toDouble(),
      mintempC: parseNum(json['mintemp_c'])?.toDouble(),
      mintempF: parseNum(json['mintemp_f'])?.toDouble(),
      avgtempC: parseNum(json['avgtemp_c'])?.toDouble(),
      avgtempF: parseNum(json['avgtemp_f'])?.toDouble(),
      maxwindMph: parseNum(json['maxwind_mph'])?.toDouble(),
      maxwindKph: parseNum(json['maxwind_kph'])?.toDouble(),
      totalprecipMm: parseNum(json['totalprecip_mm'])?.toDouble(),
      totalprecipIn: parseNum(json['totalprecip_in'])?.toDouble(),
      totalsnowCm: parseNum(json['totalsnow_cm'])?.toDouble(),
      avgvisKm: parseNum(json['avgvis_km'])?.toDouble(),
      avgvisMiles: parseNum(json['avgvis_miles'])?.toDouble(),
      avghumidity: json['avghumidity'] is int ? json['avghumidity'] : (json['avghumidity'] as num?)?.toInt(),
      dailyWillItRain: json['daily_will_it_rain'] is int ? json['daily_will_it_rain'] : (json['daily_will_it_rain'] as num?)?.toInt(),
      dailyChanceOfRain: json['daily_chance_of_rain'] is int ? json['daily_chance_of_rain'] : (json['daily_chance_of_rain'] as num?)?.toInt(),
      dailyWillItSnow: json['daily_will_it_snow'] is int ? json['daily_will_it_snow'] : (json['daily_will_it_snow'] as num?)?.toInt(),
      dailyChanceOfSnow: json['daily_chance_of_snow'] is int ? json['daily_chance_of_snow'] : (json['daily_chance_of_snow'] as num?)?.toInt(),
      condition: json['condition'] != null ? Condition.fromJson(json['condition']) : null,
      uv: parseNum(json['uv'])?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'maxtemp_c': maxtempC,
    'maxtemp_f': maxtempF,
    'mintemp_c': mintempC,
    'mintemp_f': mintempF,
    'avgtemp_c': avgtempC,
    'avgtemp_f': avgtempF,
    'maxwind_mph': maxwindMph,
    'maxwind_kph': maxwindKph,
    'totalprecip_mm': totalprecipMm,
    'totalprecip_in': totalprecipIn,
    'totalsnow_cm': totalsnowCm,
    'avgvis_km': avgvisKm,
    'avgvis_miles': avgvisMiles,
    'avghumidity': avghumidity,
    'daily_will_it_rain': dailyWillItRain,
    'daily_chance_of_rain': dailyChanceOfRain,
    'daily_will_it_snow': dailyWillItSnow,
    'daily_chance_of_snow': dailyChanceOfSnow,
    if (condition != null) 'condition': condition!.toJson(),
    'uv': uv,
  };
}

class Condition {
  final String? text;
  final String? icon;
  final int? code;

  Condition({this.text, this.icon, this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text']?.toString(),
      icon: json['icon']?.toString(),
      code: json['code'] is int ? json['code'] : (json['code'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'icon': icon,
    'code': code,
  };
}

class Astro {
  final String? sunrise;
  final String? sunset;
  final String? moonrise;
  final String? moonset;
  final String? moonPhase;
  final int? moonIllumination;

  Astro({this.sunrise, this.sunset, this.moonrise, this.moonset, this.moonPhase, this.moonIllumination});

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise']?.toString(),
      sunset: json['sunset']?.toString(),
      moonrise: json['moonrise']?.toString(),
      moonset: json['moonset']?.toString(),
      moonPhase: json['moon_phase']?.toString(),
      moonIllumination: json['moon_illumination'] is int ? json['moon_illumination'] : (json['moon_illumination'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
    'sunrise': sunrise,
    'sunset': sunset,
    'moonrise': moonrise,
    'moonset': moonset,
    'moon_phase': moonPhase,
    'moon_illumination': moonIllumination,
  };
}

class Hour {
  final int? timeEpoch;
  final String? time;
  final double? tempC;
  final double? tempF;
  final int? isDay;
  final Condition? condition;
  final double? windMph;
  final double? windKph;
  final int? windDegree;
  final String? windDir;
  final double? pressureMb;
  final double? pressureIn;
  final double? precipMm;
  final double? precipIn;
  final double? snowCm;
  final int? humidity;
  final int? cloud;
  final double? feelslikeC;
  final double? feelslikeF;
  final double? windchillC;
  final double? windchillF;
  final double? heatindexC;
  final double? heatindexF;
  final double? dewpointC;
  final double? dewpointF;
  final int? willItRain;
  final int? chanceOfRain;
  final int? willItSnow;
  final int? chanceOfSnow;
  final double? visKm;
  final double? visMiles;
  final double? gustMph;
  final double? gustKph;
  final double? uv;

  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.snowCm,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.visKm,
    this.visMiles,
    this.gustMph,
    this.gustKph,
    this.uv,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    num? parseNum(dynamic value) => value is num ? value : num.tryParse(value?.toString() ?? '');
    int? parseInt(dynamic value) => value is int ? value : (value as num?)?.toInt();

    return Hour(
      timeEpoch: parseInt(json['time_epoch']),
      time: json['time']?.toString(),
      tempC: parseNum(json['temp_c'])?.toDouble(),
      tempF: parseNum(json['temp_f'])?.toDouble(),
      isDay: parseInt(json['is_day']),
      condition: json['condition'] != null ? Condition.fromJson(json['condition']) : null,
      windMph: parseNum(json['wind_mph'])?.toDouble(),
      windKph: parseNum(json['wind_kph'])?.toDouble(),
      windDegree: parseInt(json['wind_degree']),
      windDir: json['wind_dir']?.toString(),
      pressureMb: parseNum(json['pressure_mb'])?.toDouble(),
      pressureIn: parseNum(json['pressure_in'])?.toDouble(),
      precipMm: parseNum(json['precip_mm'])?.toDouble(),
      precipIn: parseNum(json['precip_in'])?.toDouble(),
      snowCm: parseNum(json['snow_cm'])?.toDouble(),
      humidity: parseInt(json['humidity']),
      cloud: parseInt(json['cloud']),
      feelslikeC: parseNum(json['feelslike_c'])?.toDouble(),
      feelslikeF: parseNum(json['feelslike_f'])?.toDouble(),
      windchillC: parseNum(json['windchill_c'])?.toDouble(),
      windchillF: parseNum(json['windchill_f'])?.toDouble(),
      heatindexC: parseNum(json['heatindex_c'])?.toDouble(),
      heatindexF: parseNum(json['heatindex_f'])?.toDouble(),
      dewpointC: parseNum(json['dewpoint_c'])?.toDouble(),
      dewpointF: parseNum(json['dewpoint_f'])?.toDouble(),
      willItRain: parseInt(json['will_it_rain']),
      chanceOfRain: parseInt(json['chance_of_rain']),
      willItSnow: parseInt(json['will_it_snow']),
      chanceOfSnow: parseInt(json['chance_of_snow']),
      visKm: parseNum(json['vis_km'])?.toDouble(),
      visMiles: parseNum(json['vis_miles'])?.toDouble(),
      gustMph: parseNum(json['gust_mph'])?.toDouble(),
      gustKph: parseNum(json['gust_kph'])?.toDouble(),
      uv: parseNum(json['uv'])?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'time_epoch': timeEpoch,
    'time': time,
    'temp_c': tempC,
    'temp_f': tempF,
    'is_day': isDay,
    if (condition != null) 'condition': condition!.toJson(),
    'wind_mph': windMph,
    'wind_kph': windKph,
    'wind_degree': windDegree,
    'wind_dir': windDir,
    'pressure_mb': pressureMb,
    'pressure_in': pressureIn,
    'precip_mm': precipMm,
    'precip_in': precipIn,
    'snow_cm': snowCm,
    'humidity': humidity,
    'cloud': cloud,
    'feelslike_c': feelslikeC,
    'feelslike_f': feelslikeF,
    'windchill_c': windchillC,
    'windchill_f': windchillF,
    'heatindex_c': heatindexC,
    'heatindex_f': heatindexF,
    'dewpoint_c': dewpointC,
    'dewpoint_f': dewpointF,
    'will_it_rain': willItRain,
    'chance_of_rain': chanceOfRain,
    'will_it_snow': willItSnow,
    'chance_of_snow': chanceOfSnow,
    'vis_km': visKm,
    'vis_miles': visMiles,
    'gust_mph': gustMph,
    'gust_kph': gustKph,
    'uv': uv,
  };
}
