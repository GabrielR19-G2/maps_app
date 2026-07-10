import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // late -> En el momento que lo vamos a usar, ya tendremos un valor.
  late LocationBloc locationBloc;
  // se ejecuta antes del build
  @override
  void initState() {
    super.initState();
    // se dispara una vez, cuando se construye

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    // final locationBloc = BlocProvider.of<LocationBloc>(context); // esto ya no es necesario porque tenemos el late LocationBloc.

    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('MapScreen')));
  }
}
