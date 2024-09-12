// lib/app/pages/home.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final int _exactlyHour = DateTime.now().hour;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _exactlyHour < 18 && _exactlyHour > 6
          ? const Color.fromARGB(255, 53, 132, 235)
          : const Color.fromARGB(255, 17, 7, 44),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            weatherBloc.add(FetchLocationEvent('Rio de Janeiro'));
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, height * 0.07, 10.0, 0.0),
                        child: Column(
                          children: [
                            const Text(
                              'Rio de Janeiro',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              '${state.temp}º',
                              style: const TextStyle(
                                  fontSize: 65,
                                  fontWeight: FontWeight.w300,
                                  height: 1,
                                  color: Colors.white),
                            ),
                            Text(
                              state.description,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                  color: Colors.white),
                            ),
                            Text(
                              'Máx.: ${state.tempMax}º  Min.: ${state.tempMin}º',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
