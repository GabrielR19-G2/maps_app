part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation; // ultima ubicacion que conocemos del usuario
  final List<LatLng> myLocationHistory;

  // ultimo geolocalizacion
  // historia

  const LocationState({
    this.followingUser = false,
    this.lastKnownLocation,
    myLocationHistory,
  }) : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationHistory,
  }) => LocationState(
    followingUser: followingUser ?? this.followingUser,
    lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    myLocationHistory: myLocationHistory ?? this.myLocationHistory,
  );

  @override
  List<Object?> get props => [
    followingUser,
    lastKnownLocation,
    myLocationHistory,
  ];
}

final class LocationInitial extends LocationState {}
