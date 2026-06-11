import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/gps/gps_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            print('state: $state');
            // (state.isGpsEnabled && state.isGpsPermissionGranted)
            return !state.isGpsEnabled ? _EnableGpsMessage() : _AccessButton();
          },
        ),
        // _EnableGpsMessage()
        // _AccessButton(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Es necesario el acceso a GPS"),
        MaterialButton(
          color: Colors.black,
          splashColor: Colors.transparent,
          shape: const StadiumBorder(),
          onPressed: () {},
          child: const Text(
            "Solicitar accesso",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Debe de habilitar el GPS',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
