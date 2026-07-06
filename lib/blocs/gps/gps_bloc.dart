import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSuscription;

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
    // Ya no lo tenemos que hacer de manera separada, hacemos la verificacion en simultaneo con el Future
    // final isEnabled = await _checkGpsStatus();
    // final isGranted = await _isPermissionGranted();

    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    // esto es si estamos dentro del mismo bloc
    add(
      GpsAndPermissionEvent(
        isGpsEnabled: gpsInitStatus[0],
        isGpsPermissionGranted: gpsInitStatus[1],
      ),
    );
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServiceSuscription = Geolocator.getServiceStatusStream().listen((event) {
      // porque no tnemos acceso al estado
      final isEnabled = (event.index == 1) ? true : false;
      add(
        GpsAndPermissionEvent(
          isGpsEnabled: isEnabled,
          isGpsPermissionGranted: state.isGpsPermissionGranted,
        ),
      );
    });
    return isEnable;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGranted: true,
          ),
        );
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(
          GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled,
            isGpsPermissionGranted: false,
          ),
        );
        openAppSettings();
    }
  }

  // limpiar listener -> (buena practica), cuando hacemos algun listener, tenemos que limpiar el listener. Para evitar fugas de memoria.
  @override
  Future<void> close() {
    gpsServiceSuscription?.cancel();
    return super.close();
  }
}
