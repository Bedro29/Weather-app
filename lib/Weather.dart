class Weather {
  late double temp;
  late double feelslike;
  late double low;
  late double high;
  late String description;
  late String town;
  late String country;

  Weather({
    required this.temp,
    required this.feelslike,
    required this.low,
    required this.high,
    required this.description,
    required this.town,
    required this.country,
  });

  datafromWeather() {
    return "temp = ${this.temp}";
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        temp: json['main']['temp'].toDouble(),
        feelslike: json['main']['feels_like'].toDouble(),
        low: json['main']['temp_min'].toDouble(),
        high: json['main']['temp_max'].toDouble(),
        description: json['weather'][0]['description'],
        town: json['name'],
        country: json['sys']['country']);
  }
}
