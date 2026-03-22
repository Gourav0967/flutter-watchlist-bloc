part of 'reorder_status_cubit.dart';

sealed class ReorderStatusState extends Equatable {
  const ReorderStatusState();

  @override
  List<Object> get props => [];
}

final class ReorderStatusInitial extends ReorderStatusState {}

final class StartReoredering extends ReorderStatusState{}