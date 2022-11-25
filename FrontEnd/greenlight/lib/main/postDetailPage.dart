import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../main/editPostPage.dart';
import '../providers/comments.dart';
import '../providers/posts.dart';
import '../widgets/comment_item.dart';
import '../model/comment.dart';
import '../model/posting.dart';


class PostDetailPage extends StatefulWidget {
  static const routeName = '/postDetail';

  const PostDetailPage({Key? key}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  var _isLoading = false;
  final _commentFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _commentTextEditController = TextEditingController();

  Future<void> _refreshPosts(
      BuildContext context, String pk) async {
    await Provider.of<Posts>(context, listen: false).fetchAndSetPosts();
    await Provider.of<Comments>(context, listen: false)
        .fetchAndSetComments(pk);
  }

  @override
  void dispose() {
    _commentTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final id = ModalRoute.of(context)!.settings.arguments as String;
    // final post = Provider.of<Posts>(context).items.firstWhere((post) => post.pk == id);
    // final comments = Provider.of<Comments>(context).items;
    // final authUserId = Provider.of<Auth>(context, listen: false).userId as String;

    final post = ModalRoute.of(context)!.settings.arguments as Post;
    final authUserId = 'temp';  // todo: 테스트용. 추후 로그인 id 가져오기 필요


    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // 글쓴이가 자기 자신이면 수정, 삭제 버튼 활성

        actions: authUserId == post.userId
            ? <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(EditPostPage.routeName,
                  arguments: {'pk': post.pk });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('삭제'),
                  content: Text(
                    '게시글을 삭제할까요?',
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        '취소',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                    ),
                    TextButton(
                      child: Text(
                        '확인',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () async {
                        Navigator.of(ctx).pop(true);
                        try {
                          Navigator.pop(context);
                          await Provider.of<Posts>(context, listen: false)
                              .deletePost(authUserId, post.pk!);
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "삭제하지 못했습니다.",
                              textAlign: TextAlign.center,
                            ),
                          ));
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ]
            : null,
      ),
      body: Stack(children: [
        GestureDetector(
          onTap: () {
            _commentFocusNode.unfocus();
          },
          child: RefreshIndicator(
            onRefresh: () => _refreshPosts(context, post.pk!),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  // 아이콘, 익명, datetime
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Color(0xffE6E6E6),
                        child: Icon(
                          Icons.person,
                          color: Color(0xffCCCCCC),
                        ),
                      ),
                    ),
                    title: Text(post.userId!),
                    subtitle: Text(DateFormat('yy/MM/dd - HH:mm:ss', 'ko').format(post.createdDate!)),
                  ),
                  // 제목
                  Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: Text(
                      post.title!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.4,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  // 내용
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(post.content!),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  // 댓글 목록
                  // comments.isEmpty ?
                  Center(
                    child: Text('No comments'),
                  )
                  //     : Column(
                  //   children: [
                  //     Column(
                  //         children: comments
                  //             .map((comment) => CommentItem(comment.id))
                  //             .toList()),
                  //     SizedBox(
                  //       height: 100,
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
        Align(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          focusNode: _commentFocusNode,
                          controller: _commentTextEditController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return '댓글을 입력하세요.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            hintText: "댓글을 입력하세요.",
                            hintStyle: new TextStyle(color: Colors.black26),
                            suffixIcon: _isLoading
                                ? CircularProgressIndicator()
                                : IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                String commentText =
                                    _commentTextEditController.text;
                                print('input comment: ' +
                                    _commentTextEditController.text);

                                if (_formKey.currentState!.validate()) {
                                  _addComment(post.pk!,
                                      commentText);

                                  _commentTextEditController.clear();
                                  _commentFocusNode.unfocus();

                                } else {
                                  null;
                                }
                              },
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      ]),
    );
  }

  Future<void> _addComment(String pk, String contents) async {
    final comment = Comment(
        contents: contents,
        pk: pk,
        userId: null,
        datetime: null,
        id: null);
    setState(() {
      _isLoading = true;
    });
   // await Provider.of<Comments>(context, listen: false).addComment(comment);
    _refreshPosts(context, pk);
    setState(() {
      _isLoading = false;
    });
  }

}