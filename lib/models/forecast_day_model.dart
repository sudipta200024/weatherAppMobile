class ForecastDayModel {
  final Forecast? forecast;

  ForecastDayModel({this.forecast});

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      forecast: json['forecast'] != null
          ? Forecast.fromJson(json['forecast'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (forecast != null) 'forecast': forecast!.toJson(),
  };
}

class Forecast {
  final List<ForecastDay>? forecastday;

  Forecast({this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      forecastday: json['forecastday'] != null
          ? (json['forecastday'] as List)
          .map((e) => ForecastDay.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    if (forecastday != null)
      'forecastday': forecastday!.map((e) => e.toJson()).toList(),
  };
}

class ForecastDay {
  final String? date;
  final int? dateEpoch;
  final Day? day;
  final Astro? astro;
  final List<Hour>? hour;

  ForecastDay({this.date, this.dateEpoch, this.day, this.astro, this.hour});

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      date: json['date']?.toString(),
      dateEpoch: (json['date_epoch'] is int)
          ? json['date_epoch']
          : (json['date_epoch'] as num?)?.toInt(),
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
    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return Day(
      maxtempC: parseDouble(json['maxtemp_c']),
      maxtempF: parseDouble(json['maxtemp_f']),
      mintempC: parseDouble(json['mintemp_c']),
      mintempF: parseDouble(json['mintemp_f']),
      avgtempC: parseDouble(json['avgtemp_c']),
      avgtempF: parseDouble(json['avgtemp_f']),
      maxwindMph: parseDouble(json['maxwind_mph']),
      maxwindKph: parseDouble(json['maxwind_kph']),
      totalprecipMm: parseDouble(json['totalprecip_mm']),
      totalprecipIn: parseDouble(json['totalprecip_in']),
      totalsnowCm: parseDouble(json['totalsnow_cm']),
      avgvisKm: parseDouble(json['avgvis_km']),
      avgvisMiles: parseDouble(json['avgvis_miles']),
      avghumidity: parseInt(json['avghumidity']),
      dailyWillItRain: parseInt(json['daily_will_it_rain']),
      dailyChanceOfRain: parseInt(json['daily_chance_of_rain']),
      dailyWillItSnow: parseInt(json['daily_will_it_snow']),
      dailyChanceOfSnow: parseInt(json['daily_chance_of_snow']),
      condition: json['condition'] != null
          ? Condition.fromJson(json['condition'])
          : null,
      uv: parseDouble(json['uv']),
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
    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    return Condition(
      text: json['text']?.toString(),
      icon: json['icon']?.toString(),
      code: parseInt(json['code']),
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
  final String? moonIllumination;
  final int? isMoonUp;
  final int? isSunUp;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    return Astro(
      sunrise: json['sunrise']?.toString(),
      sunset: json['sunset']?.toString(),
      moonrise: json['moonrise']?.toString(),
      moonset: json['moonset']?.toString(),
      moonPhase: json['moon_phase']?.toString(),
      moonIllumination: json['moon_illumination']?.toString(),
      isMoonUp: parseInt(json['is_moon_up']),
      isSunUp: parseInt(json['is_sun_up']),
    );
  }

  Map<String, dynamic> toJson() => {
    'sunrise': sunrise,
    'sunset': sunset,
    'moonrise': moonrise,
    'moonset': moonset,
    'moon_phase': moonPhase,
    'moon_illumination': moonIllumination,
    'is_moon_up': isMoonUp,
    'is_sun_up': isSunUp,
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
  final int? visKm;
  final int? visMiles;
  final double? gustMph;
  final double? gustKph;
  final double? uv;
  final double? shortRad;
  final double? diffRad;
  final double? dni;
  final double? gti;

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
    this.shortRad,
    this.diffRad,
    this.dni,
    this.gti,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    int? parseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) return int.tryParse(value);
      return null;
    }

    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    return Hour(
      timeEpoch: parseInt(json['time_epoch']),
      time: json['time']?.toString(),
      tempC: parseDouble(json['temp_c']),
      tempF: parseDouble(json['temp_f']),
      isDay: parseInt(json['is_day']),
      condition: json['condition'] != null
          ? Condition.fromJson(json['condition'])
          : null,
      windMph: parseDouble(json['wind_mph']),
      windKph: parseDouble(json['wind_kph']),
      windDegree: parseInt(json['wind_degree']),
      windDir: json['wind_dir']?.toString(),
      pressureMb: parseDouble(json['pressure_mb']),
      pressureIn: parseDouble(json['pressure_in']),
      precipMm: parseDouble(json['precip_mm']),
      precipIn: parseDouble(json['precip_in']),
      snowCm: parseDouble(json['snow_cm']),
      humidity: parseInt(json['humidity']),
      cloud: parseInt(json['cloud']),
      feelslikeC: parseDouble(json['feelslike_c']),
      feelslikeF: parseDouble(json['feelslike_f']),
      windchillC: parseDouble(json['windchill_c']),
      windchillF: parseDouble(json['windchill_f']),
      heatindexC: parseDouble(json['heatindex_c']),
      heatindexF: parseDouble(json['heatindex_f']),
      dewpointC: parseDouble(json['dewpoint_c']),
      dewpointF: parseDouble(json['dewpoint_f']),
      willItRain: parseInt(json['will_it_rain']),
      chanceOfRain: parseInt(json['chance_of_rain']),
      willItSnow: parseInt(json['will_it_snow']),
      chanceOfSnow: parseInt(json['chance_of_snow']),
      visKm: parseInt(json['vis_km']),
      visMiles: parseInt(json['vis_miles']),
      gustMph: parseDouble(json['gust_mph']),
      gustKph: parseDouble(json['gust_kph']),
      uv: parseDouble(json['uv']),
      shortRad: parseDouble(json['short_rad']),
      diffRad: parseDouble(json['diff_rad']),
      dni: parseDouble(json['dni']),
      gti: parseDouble(json['gti']),
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
    'short_rad': shortRad,
    'diff_rad': diffRad,
    'dni': dni,
    'gti': gti,
  };
}
