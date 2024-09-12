import 'dart:async';
import 'dart:convert';
import 'package:weather_today/app/bloc/weather_event.dart';
import 'package:weather_today/app/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchLocationEvent>(_onFetchLocation);
    on<FetchWeatherDataEvent>(_onFetchWeatherData);
  }

  Future<void> _onFetchLocation(
      FetchLocationEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final response = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/geo/1.0/direct?q=${event.city}&limit=1&appid=e34410ec390c218fdbf59f907e4cc356'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = data[0]['lat'].toString();
          final lon = data[0]['lon'].toString();
          add(FetchWeatherDataEvent(lat, lon));
        } else {
          emit(WeatherError("Nenhuma localização encontrada."));
        }
      } else {
        emit(WeatherError("Houve um problema com a API"));
      }
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> _onFetchWeatherData(
      FetchWeatherDataEvent event, Emitter<WeatherState> emit) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=${event.latitude}&lon=${event.longitude}&units=metric&lang=pt_br&appid=e34410ec390c218fdbf59f907e4cc356'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(WeatherLoaded(
          data['main']['temp'].ceil().toString(),
          data['main']['temp_min'].ceil().toString(),
          data['main']['temp_max'].ceil().toString(),
          data['weather'][0]['description'][0].toUpperCase() +
              data['weather'][0]['description'].substring(1),
        ));
      } else {
        emit(WeatherError("Erro ao buscar dados do clima."));
      }
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}