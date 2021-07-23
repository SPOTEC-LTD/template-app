import 'package:bloc/bloc.dart';
import 'package:template/module/home/model/post.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(0, []));

  void refresh(List<Post> posts) {
    emit(state.copyWith(state.requestCount + 1, posts));
  }

  void loadMore(List<Post> posts) {
    posts.addAll(posts);
    emit(state.copyWith(state.requestCount + 1, posts));
  }
}
