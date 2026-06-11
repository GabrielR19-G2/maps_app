part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  //  Comparar si 2 eventos son iguales
  @override
  List<Object> get props => [];
}

class GpsAndPermissionEvent extends GpsEvent {
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  const GpsAndPermissionEvent({
    required this.isGpsEnabled,
    required this.isGpsPermissionGranted,
  });
}
