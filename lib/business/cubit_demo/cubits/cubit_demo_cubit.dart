import '../../../basic/views/refresher/refresh_status.dart';
import '../../../basic/views/refresher/refreshable.dart';
import '../apis/cubit_apis.dart';
import '../models/post_entity.dart';

part 'cubit_demo_state.dart';

class CubitDemoCubit extends RefreshableCubit<CubitDemoState> {
  CubitDemoCubit() : super(CubitDemoState());

  @override
  void refresh() {
    CubitApis.getPosts(0).then((posts) {
      final newState = state.copyWith(
        index: 0,
        refreshStatus: RefreshStatus.refreshSuccess,
        posts: posts,
        noMore: posts.isEmpty,
      );
      emit(newState);
    }).catchError((error) {
      final newState = state.copyWith(
        index: 0,
        refreshStatus: RefreshStatus.refreshFailure,
      );
      emit(newState);
    });
  }

  @override
  void loadMore() {
    CubitApis.getPosts(state.index + 5).then((posts) {
      final newState = state.copyWith(
        index: state.index + 5,
        refreshStatus: RefreshStatus.loadMoreSuccess,
        posts: List.from(state.posts)..addAll(posts),
        noMore: posts.isEmpty,
      );
      emit(newState);
    }).catchError((error) {
      final newState = state.copyWith(
        refreshStatus: RefreshStatus.loadMoreFailure,
      );
      emit(newState);
    });
  }
}
