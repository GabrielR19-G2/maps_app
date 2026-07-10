import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;
  LocationBloc() : super(LocationInitial()) {
    on<OnNewUserLocaitonEvent>(
      (event, emit) => emit(
        state.copyWith(
          lastKnownLocation: event.newLocation,
          // espare todos los valores de myLocationHistory y agrega al final la nueva ubicacion
          myLocationHistory: [...state.myLocationHistory, event.newLocation],
        ),
      ),
    );
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    add(OnNewUserLocaitonEvent(LatLng(position.latitude, position.longitude)));
  }

  void startFollowingUser() {
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(
        OnNewUserLocaitonEvent(LatLng(position.latitude, position.longitude)),
      );
    });
  }

  void stopFollowingUser() {
    // clearSuscription
    positionStream?.cancel();
    print("StopFollowingUser");
  }

  // limpiar cuando el bloc se destruye
  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
