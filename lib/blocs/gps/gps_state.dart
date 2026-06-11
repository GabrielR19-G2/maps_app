part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  // parametros por nombre
  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
  });

  // esto va a usar equatable para determinar si un objeto es igual a otro.
  // Propiedades que van a yudar a determinar si un estado es igual a otro
  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];

  @override
  String toString() =>
      '{isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted}';
}

// final class GpsInitial extends GpsState {}
