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

    var url = 'http://118.67.134.177:8080/board/temp/24';

    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<Post> loadedPosts = [];
      //extractedData.forEach((pk, postData) {
        loadedPosts.add(Post(
          pk: extractedData['pk'].toString(), // todo: toString()일괄 삭제, Post의 pk type int로 변경
          title: extractedData['title'],
          content: extractedData['content'],
          // createdDate: DateTime.parse(postData['createdDate']),  // 실제 데이터
          createdDate: DateTime.now(),
          userId: extractedData['memberId'],
        ));
      //});
      _items=[];
      _items = loadedPosts;
      notifyListeners();

    } catch (error) {
      throw (error);
    }
  }

  Future<void> addPost(Post post) async {
    final url =
        'http://118.67.134.177:8080/board/${post.userId}';

    try {
       final response = await http.post(
         Uri.parse(url),
         headers: {"Content-Type": "application/json"},
         body: json.encode({
           'title': post.title,
           'content': post.content,
           'memberId': post.userId,
         }),
       );

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
          'http://118.67.134.177:8080/board/{$newPost.userId}/$post_id';
      await http.put(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            'memberId' : newPost.userId,
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
        'http://118.67.134.177:8080/board/$user_id/$post_id';

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      notifyListeners();
      throw HttpException('Could not delete post.');
    }

    notifyListeners();
  }
}