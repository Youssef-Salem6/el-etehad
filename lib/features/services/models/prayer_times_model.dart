class PrayerTimesModel {
  String? fajr, sunrise, duhr, asr, maghreb, esha;
  String? day, weekDay, month, year;

  PrayerTimesModel({
    required this.fajr,
    required this.sunrise,
    required this.duhr,
    required this.asr,
    required this.maghreb,
    required this.esha,
    required this.day,
    required this.month,
    required this.weekDay,
    required this.year,
  });

  PrayerTimesModel.fromJson({required Map jsonData}) {
    var data = jsonData["data"]["timings"];
    var date = jsonData["data"]["date"]["hijri"];
    fajr = data["Fajr"];
    sunrise = data["Sunrise"];
    duhr = data["Dhuhr"];
    asr = data["Asr"];
    maghreb = data["Maghrib"];
    esha = data["Isha"];
    day = date["day"];
    weekDay = date["weekday"]["ar"];
    month = date["month"]["ar"];
    year = date["year"];
  }
}
