import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'easy_hook_state.dart';

class EasyHookCubit extends Cubit<EasyHookState> {
  EasyHookCubit() : super(EasyHookInitial());
}
