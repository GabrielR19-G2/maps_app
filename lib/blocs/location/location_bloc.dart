import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {});
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    print("Position: ${position}");
    // TODO: Retornar un objeto de tipo LatLng
  }

  void startFollowingUser() {
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      print("positionFollowingUser: $position");
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
