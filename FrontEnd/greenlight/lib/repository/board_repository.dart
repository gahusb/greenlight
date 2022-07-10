import '../model/post.dart';

abstract class BoardRepository {
  Future<List<Post>> getPosts();

  Future addPost(String content);

  Future updatePost(int id, String content);

  Future removePost(int id);
}