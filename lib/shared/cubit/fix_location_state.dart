part of 'fix_location_cubit.dart';

sealed class FixLocationState extends Equatable {
  const FixLocationState();

  @override
  List<Object> get props => [];
}

final class FixLocationInitial extends FixLocationState {}

final class FixLocationLoading extends FixLocationState {}

final class FixLocationNotGranted extends FixLocationState {}

final class FixLocationFailed extends FixLocationState {
  final String error;

  const FixLocationFailed({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

final class FixLocationSuccess extends FixLocationState {
  final List<String> locationDetail;

  const FixLocationSuccess({required this.locationDetail});

  @override
  // TODO: implement props
  List<Object> get props => locationDetail;
}
