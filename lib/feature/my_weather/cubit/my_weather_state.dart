part of 'my_weather_cubit.dart';

abstract class MyWeatherState extends Equatable {
  const MyWeatherState();

  @override
  List<Object> get props => [];
}

final class MyWeatherInitial extends MyWeatherState {}

final class MyWeatherLoading extends MyWeatherState {}

final class MyWeatherFailed extends MyWeatherState {
  final String message;

  const MyWeatherFailed({required this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

final class MyWeatherSuccess extends MyWeatherState {
  final WeatherForecastModel weatherData;

  const MyWeatherSuccess({required this.weatherData});
  @override
  // TODO: implement props
  List<Object> get props => [weatherData];
}

final class MyWeatherOffline extends MyWeatherState {}
