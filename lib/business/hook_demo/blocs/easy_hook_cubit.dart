import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../cubit_demo/apis/cubit_apis.dart';
import '../../cubit_demo/models/post_entity.dart';

part 'easy_hook_state.dart';

class EasyHookCubit extends Cubit<EasyHookState> {
  EasyHookCubit() : super(EasyHookInitial());

  Future<List<PostEntity>> requestPsots(int start) {
    return CubitApis.getPosts(start);
  }
}
