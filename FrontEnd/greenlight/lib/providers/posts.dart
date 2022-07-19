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

    // var url =
    //     '118.67.134.177:8080/board';
    try {
      //final response = await http.get(Uri.parse(url));
      //final extractedData = json.decode(response.body) as Map<String, dynamic>;

      var list_data =
      {'post_id': '1' ,
        'user_id': 'naeun',
        'title': '테스트',
        'content': '테스트 내용입니다.',
        'fst_crt_date': '2022-07-18'};

      var response = jsonEncode(list_data);
      final extractedData = json.decode(response) as Map<String, dynamic>;

      print('response : ${response}');

      print('extractedData : ${extractedData}');

      if (extractedData == null) {
        return;
      }

      final List<Post> loadedPosts = _items;
      loadedPosts.add(Post(
        pk: extractedData['postId'],
        title: extractedData['title'],
        content: extractedData['content'],
        // createdDate: DateTime.parse(extractedData['fst_crt_date']),
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
        '118.67.134.177/board/$post.userId';
    final timeStamp = DateTime.now();

    try {
      // final response = await http.post(
      //   Uri.parse(url),
      //   body: json.encode({
      //     'title': post.title,
      //     'content': post.content,
      //     'createdDate': timeStamp.toIso8601String(),
      //     'userId': post.userId,
      //   }),
      // );

      final newPost = Post(
        title: post.title,
        content: post.content,
        createdDate: timeStamp,
        userId: post.userId,
        // pk: json.decode(response.body)['name'],
        pk: '1',
      );

      _items.add(newPost);

      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updatePost(String? post_id, Post newPost) async {
    final postIndex = _items.indexWhere((post) => post.pk == post_id);
    if (postIndex >= 0) {
      final url =
          '118.67.134.177/board/$newPost.userId/$post_id';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'member_id' : newPost.userId,
            'title': newPost.title,
            'content': newPost.content,
          }));
      _items[postIndex] = newPost;
      notifyListeners();
    } else {
      print('Cannot find any post of id $post_id');
    }
  }

  Future<void> deletePost(String? user_id, String post_id) async {
    final url =
        '118.67.134.177/board/$user_id/$post_id';

    final existingPostIndex = _items.indexWhere((post) => post.pk == post_id);
    Post? existingPost = _items[existingPostIndex];
    _items.removeAt(existingPostIndex);
    // notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingPostIndex, existingPost);
      notifyListeners();
      throw HttpException('Could not delete post.');
    }
    _items.removeWhere((post) => post.pk == post_id);
    notifyListeners();
    existingPost = null;
  }
}