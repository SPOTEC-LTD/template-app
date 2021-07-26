import 'package:bloc/bloc.dart';
import 'package:template/module/cubit_demo/models/post_entity.dart';
import 'package:template/services/http/http_service.dart';

part 'cubit_demo_state.dart';

class CubitDemoCubit extends Cubit<CubitDemoState> {
  CubitDemoCubit() : super(CubitDemoState(0, 0, PostStatus.initial, []));

  void refresh() {
    HttpService.anyRequest<List<dynamic>>('get',
            'https://jsonplaceholder.typicode.com/posts?_start=0&_limit=5}')
        .then((list) {
      var posts = list.map((e) => PostEntity().fromJson(e)).toList();
      emit(
          state.copyWith(state.requestCount + 1, 1, PostStatus.success, posts));
    });
  }

  void loadMore() {
    // posts.addAll(posts);
    // emit(state.copyWith(state.requestCount + 1, posts));
  }
}
