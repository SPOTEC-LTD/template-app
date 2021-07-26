part of 'cubit_demo_cubit.dart';

class CubitDemoState {
  final int requestCount;
  final int index;
  final RefreshStatus status;
  final List<PostEntity> posts;

  CubitDemoState({
    this.requestCount = 0,
    this.index = 0,
    this.status = RefreshStatus.initial,
    this.posts = const [],
  });

  CubitDemoState copyWith(
    int index,
    int requestCount,
    RefreshStatus status,
    List<PostEntity> posts,
  ) {
    return CubitDemoState(
      requestCount: requestCount,
      index: index,
      status: status,
      posts: posts,
    );
  }
}
