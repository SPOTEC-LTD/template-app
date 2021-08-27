part of 'cubit_demo_cubit.dart';

class CubitDemoState with RefreshableMixin {
  final int index;
  final List<PostEntity> posts;

  @override
  bool get isListEmpty => posts.isEmpty;

  @override
  bool noMore = true;

  @override
  RefreshStatus refreshStatus;

  CubitDemoState({
    this.index = 0,
    this.posts = const [],
    this.refreshStatus = RefreshStatus.initial,
    this.noMore = false,
  });

  CubitDemoState copyWith({
    int? index,
    RefreshStatus? refreshStatus,
    List<PostEntity>? posts,
    bool? noMore,
  }) {
    return CubitDemoState(
      index: index ?? this.index,
      refreshStatus: refreshStatus ?? this.refreshStatus,
      posts: posts ?? this.posts,
      noMore: noMore ?? this.noMore,
    );
  }
}
