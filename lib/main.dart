import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorder_list_assignment/business_logic/bloc/stocks_bloc.dart';
import 'package:reorder_list_assignment/business_logic/cubit/reorder_status_cubit.dart';
import 'package:reorder_list_assignment/repositories/stock_repo.dart';
import 'package:reorder_list_assignment/ui/screens/stock_list_screen.dart';

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
