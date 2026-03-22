import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reorder_list_assignment/models/stocks_model.dart';

import '../../repositories/stock_repo.dart';

part 'stocks_event.dart';
part 'stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final StockRepo _stockRepo;
  StocksBloc({required StockRepo stockRepo})
    : _stockRepo = stockRepo,
      super(StocksInitial()) {
    on<GetStock>((event, emit) async {
      emit(StocksLoading());

      await emit.forEach<List<StocksModel>>(
        _stockRepo.getStocks(),
        onData: (newData) {
          return StocksFetched(stocks: newData);
        },
        onError: (error, stackTrace) =>
            StocksError(e: error.toString(), stackTrace: stackTrace.toString()),
      );
    });
    on<ReorderStocks>((event, emit) {
      _stockRepo.reorderStocks(event.oldIndex, event.newIndex);

      if (state is StocksFetched) {
        final currentList = List<StocksModel>.from(
          (state as StocksFetched).stocks,
        );

        int newIndex = event.newIndex;
        if (event.oldIndex < newIndex) {
          newIndex -= 1;
        }

        final item = currentList.removeAt(event.oldIndex);
        currentList.insert(newIndex, item);

        emit(StocksFetched(stocks: currentList));
      }
    });
  }
}
