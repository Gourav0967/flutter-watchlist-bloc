import 'package:equatable/equatable.dart';

class StocksModel extends Equatable {
   final int id ;
   final String name;
   final double price;
   final double change;
   const StocksModel({
    required this.id,
    required this.change,
    required this.name,
    required this.price
  });

   StocksModel copyWith({
    int? id,
    String? name,
    double? price,
    double? change
   })=>StocksModel(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    change: change ?? this.change
   );
  @override
  // TODO: implement props
  List<Object?> get props => [change,name,price,id];
}