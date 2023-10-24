part of 'search_weather_cubit.dart';

abstract class SearchWeatherState extends Equatable {
  const SearchWeatherState();

  @override
  List<Object> get props => [];
}

final class SearchWeatherInitial extends SearchWeatherState {}

final class SearchWeatherLoading extends SearchWeatherState {}

final class SearchWeatherFailed extends SearchWeatherState {
  final String message;

  const SearchWeatherFailed({required this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}

final class SearchWeatherSuccess extends SearchWeatherState {
  final WeatherForecastModel weatherData;

  const SearchWeatherSuccess({required this.weatherData});
  @override
  // TODO: implement props
  List<Object> get props => [weatherData];
}

final class SearchWeatherOffline extends SearchWeatherState {}
