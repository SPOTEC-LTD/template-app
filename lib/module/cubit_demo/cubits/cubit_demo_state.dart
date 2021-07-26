part of 'cubit_demo_cubit.dart';

enum PostStatus {
  initial,
  success,
  failure,
}

class CubitDemoState {
  final int requestCount;
  final int index;
  final PostStatus status;
  final List<PostEntity> posts;

  CubitDemoState(
    this.requestCount,
    this.index,
    this.status,
    this.posts,
  );

  CubitDemoState copyWith(
    int index,
    int requestCount,
    PostStatus status,
    List<PostEntity> posts,
  ) {
    return CubitDemoState(index, requestCount, status, posts);
  }
}
