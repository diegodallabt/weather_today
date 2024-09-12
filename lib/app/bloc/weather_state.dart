abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final String temp;
  final String tempMin;
  final String tempMax;
  final String description;

  WeatherLoaded(this.temp, this.tempMin, this.tempMax, this.description);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}