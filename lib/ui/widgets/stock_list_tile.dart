import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorder_list_assignment/business_logic/cubit/reorder_status_cubit.dart';

class StockListTile extends StatelessWidget {
  final name;
  final price;
  final change;
  const StockListTile({super.key,required this.name,required this.price,required this.change});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return  Card(
       elevation: 2,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Text("Price: $price"),
            Text(
              "Change: ${change.toStringAsFixed(2)}",
              style: TextStyle(
                color: change > 0
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
        trailing: BlocBuilder<ReorderStatusCubit,ReorderStatusState>(builder: (context,state){
          return state is StartReoredering ? Icon(Icons.unfold_more):SizedBox.shrink();
        }),
      ),
    );
  }
}
