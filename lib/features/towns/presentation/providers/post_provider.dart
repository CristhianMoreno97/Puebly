import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/towns/domain/repositories/towns_repository.dart';
import 'package:puebly/features/towns/presentation/providers/towns_repository_provider.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';

final postProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  final townsRepository = ref.watch(townsRepositoryProvider);
  return PostNotifier(townsRepository);
});

class PostNotifier extends StateNotifier<PostState> {
  final TownsRepository _townsRepository;

  PostNotifier(this._townsRepository) : super(PostState());

  void setPost(Post post) {
    state = state.copyWith(post: post, isLoading: false);
  }

  Future<PostState> getPost(int id) async {
    state = state.copyWith(isLoading: true);
    final post = await _townsRepository.getPost(id);
    setPost(post);
    // state = state.copyWith(isLoading: false);
    return state;
  }
}

class PostState {
  final bool isLoading;
  final bool isFailed;
  final Post? post;

  PostState({
    this.isLoading = true,
    this.isFailed = false,
    this.post,
  });

  PostState copyWith({
    bool? isLoading,
    bool? isFailed,
    Post? post,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      post: post ?? this.post,
    );
  }
}
