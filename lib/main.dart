import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/screens/screens.dart';

void main() {
  // confirmar estados primero y luego construir el bloc. (en caso de preocuparnos demasiado por el primer estado inicial)
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => GpsBloc())],
      child: const MapsApp(),
    ),
  );
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapsApp',
      home: LoadingScreen(),
    );
  }
}
