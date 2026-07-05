import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc()
    : super(GpsState(isGpsEnabled: false, isGpsPermissionGranted: false)) {
    // emitir nueva instancia del state
    on<GpsAndPermissionEvent>(
      (event, emit) => emit(
        state.copyWith(
          isGpsEnabled: event.isGpsEnabled,
          isGpsPermissionGranted: event.isGpsPermissionGranted,
        ),
      ),
    );
    _init();
  }

  Future<void> _init() async {
    // Verificando
    final isEnabled = await _checkGpsStatus();
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((event) {
      // porque no tnemos acceso al estado
      final isEnabled = (event.index == 1) ? true : false;
      print("Service status: $isEnabled ");
    });
    return isEnable;
  }

  // limpiar listener -> (buena practica), cuando hacemos algun listener, tenemos que limpiar el listener. Para evitar fugas de memoria.
  @override
  Future<void> close() {
    return super.close();
  }
}
