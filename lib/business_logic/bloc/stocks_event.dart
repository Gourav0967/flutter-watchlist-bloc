part of 'stocks_bloc.dart';

sealed class StocksEvent extends Equatable {
  const StocksEvent();

  @override
  List<Object> get props => [];
}

class GetStock extends StocksEvent{
}
class ReorderStocks extends StocksEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderStocks(this.oldIndex, this.newIndex);
}