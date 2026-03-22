import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorder_list_assignment/business_logic/bloc/stocks_bloc.dart';
import 'package:reorder_list_assignment/business_logic/cubit/reorder_status_cubit.dart';
import 'package:reorder_list_assignment/ui/widgets/popup_widget.dart';
import 'package:reorder_list_assignment/ui/widgets/stock_list_tile.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  State<StockListScreen> createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StocksBloc>().add(GetStock());
Future.delayed(Duration.zero, () {
    PopupWidget.showAlert(context);
  });
  }


  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withValues(alpha: 0.05);
    final Color evenItemColor = colorScheme.secondary.withValues(alpha: 0.15);
    final Color draggableItemColor = Colors.blue[100] ?? Colors.blue;

    Widget proxyDecorator(
      Widget child,
      int index,
      Animation<double> animation,
    ) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: elevation,
              color: draggableItemColor,
              shadowColor: draggableItemColor,
              child: child,
            ),
          );
        },
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Stocks')),
      body: BlocBuilder<StocksBloc, StocksState>(
        builder: (context, state) {
          if (state is StocksFetched) {
            return ReorderableListView.builder(
              itemCount: state.stocks.length,
              proxyDecorator: proxyDecorator,
              onReorderStart: (val){
                context.read<ReorderStatusCubit>().startReoredering();
              },
              onReorderEnd: (val){
                 context.read<ReorderStatusCubit>().stopReordering();
              },
              onReorder: (oldIndex, newIndex) {
                context.read<StocksBloc>().add(
                  ReorderStocks(oldIndex, newIndex),
                );
              },
              itemBuilder: (context, index) {
                final stock = state.stocks[index];

                return Column(
                  key: ValueKey(stock.id),
                  children: [
                    StockListTile(name: stock.name, price: stock.price.toStringAsFixed(2), change: stock.change),
                    Divider(height: 1),
                  ],
                );
              },
            );
          } else if (state is StocksLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StocksError) {
            return Center(child: Text(state.e));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
