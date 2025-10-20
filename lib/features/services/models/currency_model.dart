// currency_model.dart

class CurrencyModel {
  final String base;
  final Map<String, double> rates;
  final String date;

  CurrencyModel({
    required this.base,
    required this.rates,
    required this.date,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      base: json['base'] as String,
      rates: Map<String, double>.from(
        (json['rates'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),
      date: json['date'] as String,
    );
  }
}