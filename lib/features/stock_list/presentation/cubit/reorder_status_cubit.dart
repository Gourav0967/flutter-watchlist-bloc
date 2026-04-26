import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reorder_status_state.dart';

class ReorderStatusCubit extends Cubit<ReorderStatusState> {
  ReorderStatusCubit() : super(ReorderStatusInitial());
  void startReoredering(){
    emit(StartReoredering());
  }
  void stopReordering(){
    emit(ReorderStatusInitial());
  }
}
