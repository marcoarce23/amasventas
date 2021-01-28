import '../BaseEntity.dart';

class WeatherForecast extends BaseEntity {
  String date;
  int temperatureC;
  int temperatureF;
  String summary;

  WeatherForecast({
    this.date,
    this.summary,
    this.temperatureC,
    this.temperatureF,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'summary': summary,
        'temperatureC': temperatureC,
        'temperatureF': temperatureF,
      };

  fromJson(Map<String, dynamic> json) => new WeatherForecast(
        date: json['date'],
        summary: json['summary'],
        temperatureC: json['temperatureC'],
        temperatureF: json['temperatureF'],
      );
}
