abstract class WeatherEvent {}

class FetchLocationEvent extends WeatherEvent {
  final String city;

  FetchLocationEvent(this.city);
}

class FetchWeatherDataEvent extends WeatherEvent {
  final String latitude;
  final String longitude;

  FetchWeatherDataEvent(this.latitude, this.longitude);
}