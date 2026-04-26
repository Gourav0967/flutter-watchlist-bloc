part of 'stocks_list_bloc.dart';

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
 @override
  List<Object> get props => [oldIndex,newIndex];
}

class DeleteStock extends StocksEvent {
  final int index;
  const DeleteStock(this.index);
  
  @override
  List<Object> get props => [index];
}