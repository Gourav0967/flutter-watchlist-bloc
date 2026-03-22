import 'dart:math';

import 'package:reorder_list_assignment/models/stocks_model.dart';

class StockRepo {
  List<StocksModel> _stocks = [
    StocksModel(id: 1, change: 0.2, name: 'RELIANCE', price: 1230),
    StocksModel(id: 2, change: 0.4, name: 'HDFCBANK', price: 1230),
    StocksModel(id: 3, change: -0.2, name: 'ASIANPAINTS', price: 1230),
    StocksModel(id: 4, change: 0.6, name: 'NIFTY IT', price: 1230),
    StocksModel(id: 6, change: 0.2, name: 'MRF', price: 1230),
    StocksModel(id: 7, change: -0.4, name: 'RELIANCE SEP 1370 PE', price: 1230),
    StocksModel(id: 8, change: -0.8, name: 'TCS', price: 1230),
    StocksModel(id: 9, change: 0.3, name: 'INFOSYS', price: 1230),
  ];
  final Random _random = Random();
  Stream<List<StocksModel>> getStocks() async* {
    while (true) {
      _stocks = _stocks.map((stock) {
        final change =
            double.parse(_random.nextDouble().toStringAsFixed(2)) *
            0.1 *
            (_random.nextBool() ? 1 : -1);

        final newPrice = stock.price + (stock.price * change);

        return stock.copyWith(price: newPrice, change: change);
      }).toList();

      yield List.from(_stocks);

      await Future.delayed(Duration(seconds: 1));
    }
  }
  void reorderStocks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _stocks.removeAt(oldIndex);
    _stocks.insert(newIndex, item);
  }
}
