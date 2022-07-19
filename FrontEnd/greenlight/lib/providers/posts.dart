import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../model/http_exception.dart';
import '../model/posting.dart';

class Posts with ChangeNotifier {
  List<Post> _items = [];
  final String? authToken;
  final String? userId;

  Posts(this.authToken, this.userId, this._items);

  List<Post> get items {
    _items.sort((a, b) {
      return b.createdDate!.compareTo(a.createdDate!);
    });
    return [..._items];
  }

  Future<void> fetchAndSetPosts() async {
    print('fetchAndSetPosts');
    final filterString = 'orderBy="boardId"&equalTo="';
    var url =
        '118.67.134.177:8080/board';
    try {
      final response = await http.get(Uri.parse(url));
      // var list_data =
      // {'post_id': '1' ,
      //   'user_id': 'naeun',
      //   'title': '테스트',
      //   'content': '테스트 내용입니다.',
      //   'fst_crt_date': '2022-07-18'};
      //
      //
      // var response = jsonEncode(list_data);
      // final extractedData = json.decode(response) as Map<String, dynamic>;

      print('response : ${response}');

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print('extractedData : ${extractedData}');

      if (extractedData == null) {
        return;
      }

      final List<Post> loadedPosts = _items;
      loadedPosts.add(Post(
        pk: extractedData['postId'],
        title: extractedData['title'],
        content: extractedData['content'],
        createdDate: DateTime.parse(extractedData['fst_crt_date']),
        userId: extractedData['user_id'],
      ));

      _items = loadedPosts;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addPost(Post post) async {
    final url =
        '/서버 url/posts.json?auth=$authToken';
    final timeStamp = DateTime.now();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': post.title,
          'contents': post.content,
          'datetime': timeStamp.toIso8601String(),
          'creatorId': post.userId,
        }),
      );

      final newPost = Post(
        title: post.title,
        content: post.content,
        createdDate: timeStamp,
        userId: post.userId,
        pk: json.decode(response.body)['name'],
      );

      _items.add(newPost);

      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updatePost(String? id, Post newPost) async {
    final postIndex = _items.indexWhere((post) => post.pk == id);
    if (postIndex >= 0) {
      final url =
          '/서버 url/posts/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newPost.title,
            'contents': newPost.content,
          }));
      _items[postIndex] = newPost;
      notifyListeners();
    } else {
      print('Cannot find any post of id $id');
    }
  }

  Future<void> deletePost(String id) async {
    final url =
        '/서버 url/posts/$id.json?auth=$authToken';

    final existingPostIndex = _items.indexWhere((post) => post.pk == id);
    Post? existingPost = _items[existingPostIndex];
    _items.removeAt(existingPostIndex);
    // notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingPostIndex, existingPost);
      notifyListeners();
      throw HttpException('Could not delete post.');
    }
    _items.removeWhere((post) => post.pk == id);
    notifyListeners();
    existingPost = null;
  }
}