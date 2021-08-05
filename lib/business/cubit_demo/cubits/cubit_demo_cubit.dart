import 'package:bloc/bloc.dart';
import 'package:template/business/cubit_demo/apis/cubit_apis.dart';
import 'package:template/business/cubit_demo/models/post_entity.dart';
import 'package:template/basic/views/refresher/refresh_mixin.dart';
import 'package:template/basic/views/refresher/refresh_status.dart';

part 'cubit_demo_state.dart';

class CubitDemoCubit extends Cubit<CubitDemoState> {
  CubitDemoCubit() : super(CubitDemoState());

  void refresh() {
    CubitApis.getPosts(0).then((posts) {
      var newState = state.copyWith(
        index: 0,
        refreshStatus: RefreshStatus.refreshSuccess,
        posts: posts,
        noMore: posts.isEmpty,
      );
      emit(newState);
    }).catchError((error) {
      var newState = state.copyWith(
        index: 0,
        refreshStatus: RefreshStatus.refreshFailure,
      );
      emit(newState);
    });
  }

  void loadMore() {
    CubitApis.getPosts(state.index + 5).then((posts) {
      var newState = state.copyWith(
        index: state.index + 5,
        refreshStatus: RefreshStatus.loadMoreSuccess,
        posts: List.from(state.posts)..addAll(posts),
        noMore: posts.isEmpty,
      );
      emit(newState);
    }).catchError((error) {
      var newState = state.copyWith(
        refreshStatus: RefreshStatus.loadMoreFailure,
      );
      emit(newState);
    });
  }
}
