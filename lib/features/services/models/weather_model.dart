class WeatherModel {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map json) {
    return WeatherModel(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

class Location {
  final String name;
  final String country;
  final double lat;
  final double lon;
  final String localtime;

  Location({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
    required this.localtime,
  });

  factory Location.fromJson(Map json) {
    return Location(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      localtime: json['localtime'] ?? '',
    );
  }
}

class Current {
  final double tempC;
  final int isDay;
  final Condition condition;
  final double windKph;
  final int humidity;
  final double feelslikeC;

  Current({
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.feelslikeC,
  });

  factory Current.fromJson(Map json) {
    return Current(
      tempC: (json['temp_c'] as num?)?.toDouble() ?? 0.0,
      isDay: json['is_day'] ?? 0,
      condition: Condition.fromJson(json['condition']),
      windKph: (json['wind_kph'] as num?)?.toDouble() ?? 0.0,
      humidity: json['humidity'] ?? 0,
      feelslikeC: (json['feelslike_c'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Condition {
  final String text;
  final String icon;

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map json) {
    return Condition(text: json['text'] ?? '', icon: json['icon'] ?? '');
  }
}

class Forecast {
  final List<Forecastday> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map json) {
    return Forecast(
      forecastday:
          (json['forecastday'] as List?)
              ?.map((item) => Forecastday.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class Forecastday {
  final String date;
  final Day day;
  final Astro astro;

  Forecastday({required this.date, required this.day, required this.astro});

  factory Forecastday.fromJson(Map json) {
    return Forecastday(
      date: json['date'] ?? '',
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
    );
  }
}

class Day {
  final double maxtempC;
  final double mintempC;
  final double avgtempC;
  final Condition condition;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.avgtempC,
    required this.condition,
  });

  factory Day.fromJson(Map json) {
    return Day(
      maxtempC: (json['maxtemp_c'] as num?)?.toDouble() ?? 0.0,
      mintempC: (json['mintemp_c'] as num?)?.toDouble() ?? 0.0,
      avgtempC: (json['avgtemp_c'] as num?)?.toDouble() ?? 0.0,
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Astro {
  final String sunrise;
  final String sunset;

  Astro({required this.sunrise, required this.sunset});

  factory Astro.fromJson(Map json) {
    return Astro(sunrise: json['sunrise'] ?? '', sunset: json['sunset'] ?? '');
  }
}
