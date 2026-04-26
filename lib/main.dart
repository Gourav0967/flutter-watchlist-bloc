import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorder_list_assignment/features/stock_list/presentation/bloc/stocks_list_bloc.dart';
import 'package:reorder_list_assignment/features/stock_list/presentation/cubit/reorder_status_cubit.dart';
import 'package:reorder_list_assignment/features/stock_list/data/repositories/stock_repo.dart';
import 'package:reorder_list_assignment/features/stock_list/presentation/screens/stock_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=> StocksBloc(stockRepo: StockRepo())),
      BlocProvider(create: (context)=> ReorderStatusCubit())
    ], child:MaterialApp(home:  StockListScreen(),));
  }
}
