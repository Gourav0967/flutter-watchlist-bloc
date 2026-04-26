import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorder_list_assignment/features/stock_list/presentation/bloc/stocks_list_bloc.dart';
import 'package:reorder_list_assignment/features/stock_list/presentation/cubit/reorder_status_cubit.dart';
import 'package:reorder_list_assignment/features/stock_list/presentation/widgets/popup_widget.dart';
import 'package:reorder_list_assignment/features/stock_list/presentation/widgets/stock_list_tile.dart';

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
      if(mounted) {
      PopupWidget.showAlert(context);}
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
          return Material(elevation: elevation, child: child);
        },
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Watchlist"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: BlocBuilder<StocksBloc, StocksState>(
          builder: (context, state) {
            if (state is StocksFetched) {
              if (state.stocks.isEmpty) {
                return Center(child: Text("No stocks available"));
              }
              return ReorderableListView.builder(
                itemCount: state.stocks.length,
                proxyDecorator: proxyDecorator,
                onReorderStart: (val) {
                  context.read<ReorderStatusCubit>().startReoredering();
                },
                onReorderEnd: (val) {
                  context.read<ReorderStatusCubit>().stopReordering();
                },
                onReorder: (oldIndex, newIndex) {
                  context.read<StocksBloc>().add(
                    ReorderStocks(oldIndex, newIndex),
                  );
                },
                itemBuilder: (context, index) {
                  final stock = state.stocks[index];
                  return Dismissible(
                    key: ValueKey(stock.id),
                    direction: DismissDirection.endToStart,

                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),

                    onDismissed: (_) {
                      context.read<StocksBloc>().add(DeleteStock(index));
                    },

                    child: BlocBuilder<ReorderStatusCubit, ReorderStatusState>(
                      builder: (context, statusState) {
                        return StockListTile(
                          name: stock.name,
                          price: stock.price.toStringAsFixed(2),
                          change: stock.change,
                          reordering: statusState is StartReoredering,
                        );
                      },
                    ),
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
      ),
    );
  }
}
