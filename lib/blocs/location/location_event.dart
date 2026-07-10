part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

/// recibiendo nueva ubicacion
class OnNewUserLocaitonEvent extends LocationEvent {
  final LatLng newLocation;
  // parametros posicionales
  const OnNewUserLocaitonEvent(this.newLocation);
}
