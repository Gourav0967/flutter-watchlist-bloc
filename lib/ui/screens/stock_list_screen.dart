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
          return  Material(
              elevation: elevation,
              child: child,
            );
        },
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist'),centerTitle: true,),
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

                return StockListTile(name: stock.name, price: stock.price.toStringAsFixed(2), change: stock.change,key: ValueKey(stock.id),);
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
