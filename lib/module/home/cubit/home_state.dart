part of 'home_cubit.dart';

class HomeState {
  final int requestCount;
  final List<Post> posts;

  HomeState(
    this.requestCount,
    this.posts,
  );

  HomeState copyWith(int requestCount, List<Post> posts) {
    return HomeState(requestCount, posts);
  }
}
