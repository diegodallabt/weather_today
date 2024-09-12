import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/bloc/weather_bloc.dart';
import 'app/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima Tempo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 29, 82, 228)),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => WeatherBloc(),
        child: const Home(),
      ),
    );
  }
}
