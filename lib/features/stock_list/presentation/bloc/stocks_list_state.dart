part of 'stocks_list_bloc.dart';

sealed class StocksState extends Equatable {
  const StocksState();
  
  @override
  List<Object> get props => [];
}

final class StocksInitial extends StocksState {}
final class StocksLoading extends StocksState {}
final class StocksFetched extends StocksState {
  final List<StocksModel> stocks ;
  const StocksFetched({required this.stocks});
  @override
  List<Object> get props => [stocks];
}
final class StocksError extends StocksState {
  final String e;
  final String stackTrace;
  const StocksError({required this.e, required this.stackTrace});

  @override
  List<Object> get props => [e,stackTrace];
}
