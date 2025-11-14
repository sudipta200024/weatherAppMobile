class CurrentWeatherModel {
  Current? current;

  CurrentWeatherModel({this.current});

  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    current =
    json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    return data;
  }
}

class Current {
  int? lastUpdatedEpoch;
  String? lastUpdated;

  double? tempC;
  double? tempF;
  int? isDay;

  Condition? condition;

  double? windMph;
  double? windKph;
  int? windDegree;
  String? windDir;

  double? pressureMb;
  double? pressureIn;

  double? precipMm;
  double? precipIn;

  int? humidity;
  int? cloud;

  double? feelslikeC;
  double? feelslikeF;

  double? windchillC;
  double? windchillF;

  double? heatindexC;
  double? heatindexF;

  double? dewpointC;
  double? dewpointF;

  double? visKm;
  double? visMiles;

  double? uv;

  double? gustMph;
  double? gustKph;

  double? shortRad;
  double? diffRad;
  double? dni;
  double? gti;

  Current();

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdatedEpoch = json['last_updated_epoch'];
    lastUpdated = json['last_updated'];

    tempC = (json['temp_c'] as num?)?.toDouble();
    tempF = (json['temp_f'] as num?)?.toDouble();
    isDay = json['is_day'];

    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;

    windMph = (json['wind_mph'] as num?)?.toDouble();
    windKph = (json['wind_kph'] as num?)?.toDouble();
    windDegree = json['wind_degree'];
    windDir = json['wind_dir'];

    pressureMb = (json['pressure_mb'] as num?)?.toDouble();
    pressureIn = (json['pressure_in'] as num?)?.toDouble();

    precipMm = (json['precip_mm'] as num?)?.toDouble();
    precipIn = (json['precip_in'] as num?)?.toDouble();

    humidity = json['humidity'];
    cloud = json['cloud'];

    feelslikeC = (json['feelslike_c'] as num?)?.toDouble();
    feelslikeF = (json['feelslike_f'] as num?)?.toDouble();

    windchillC = (json['windchill_c'] as num?)?.toDouble();
    windchillF = (json['windchill_f'] as num?)?.toDouble();

    heatindexC = (json['heatindex_c'] as num?)?.toDouble();
    heatindexF = (json['heatindex_f'] as num?)?.toDouble();

    dewpointC = (json['dewpoint_c'] as num?)?.toDouble();
    dewpointF = (json['dewpoint_f'] as num?)?.toDouble();

    visKm = (json['vis_km'] as num?)?.toDouble();
    visMiles = (json['vis_miles'] as num?)?.toDouble();

    uv = (json['uv'] as num?)?.toDouble();

    gustMph = (json['gust_mph'] as num?)?.toDouble();
    gustKph = (json['gust_kph'] as num?)?.toDouble();

    shortRad = (json['short_rad'] as num?)?.toDouble();
    diffRad = (json['diff_rad'] as num?)?.toDouble();
    dni = (json['dni'] as num?)?.toDouble();
    gti = (json['gti'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['last_updated_epoch'] = lastUpdatedEpoch;
    data['last_updated'] = lastUpdated;

    data['temp_c'] = tempC;
    data['temp_f'] = tempF;
    data['is_day'] = isDay;

    if (condition != null) {
      data['condition'] = condition!.toJson();
    }

    data['wind_mph'] = windMph;
    data['wind_kph'] = windKph;
    data['wind_degree'] = windDegree;
    data['wind_dir'] = windDir;

    data['pressure_mb'] = pressureMb;
    data['pressure_in'] = pressureIn;

    data['precip_mm'] = precipMm;
    data['precip_in'] = precipIn;

    data['humidity'] = humidity;
    data['cloud'] = cloud;

    data['feelslike_c'] = feelslikeC;
    data['feelslike_f'] = feelslikeF;

    data['windchill_c'] = windchillC;
    data['windchill_f'] = windchillF;

    data['heatindex_c'] = heatindexC;
    data['heatindex_f'] = heatindexF;

    data['dewpoint_c'] = dewpointC;
    data['dewpoint_f'] = dewpointF;

    data['vis_km'] = visKm;
    data['vis_miles'] = visMiles;

    data['uv'] = uv;

    data['gust_mph'] = gustMph;
    data['gust_kph'] = gustKph;

    data['short_rad'] = shortRad;
    data['diff_rad'] = diffRad;
    data['dni'] = dni;
    data['gti'] = gti;

    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }
}
