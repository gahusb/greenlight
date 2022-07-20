import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/posting.dart';
import '../providers/posts.dart';
import '../providers/auth.dart';

class EditPostPage extends StatefulWidget {
  static const routeName = '/editPost';

  @override
   createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _contentsFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedPost = Post(
    pk: null,
    title: '',
    content: '',
    userId: '',
  );

  var _initValues = {
    'title': '',
    'content': '',
  };

  var _isInit = true;
  var _isLoading = false;
  var arguments = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (_isInit) {
      final pk = arguments['pk'];
      if (pk != null) {
        _editedPost = Provider.of<Posts>(context, listen: false)
            .items
            .firstWhere((post) => post.pk == pk);
        _initValues = {
          'title': _editedPost.title ?? '',
          'content': _editedPost.content ?? '',
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _contentsFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedPost.pk != null) {
      await Provider.of<Posts>(context, listen: false)
          .updatePost(_editedPost.pk, _editedPost);
    } else {
      try {
        await Provider.of<Posts>(context, listen: false).addPost(_editedPost);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error ocurred.'),
            content: Text('오류가 발생했습니다.'),
            actions: <Widget>[
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // final userId = Provider.of<Auth>(context).userId;

    return Scaffold(
      appBar: AppBar(
        title: arguments['pk'] != null ? Text('글 수정') : Text('글 작성'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(
                    labelText: '제목',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_contentsFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '제목을 입력해주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedPost = Post(
                      title: value,
                      content: _editedPost.content,
                      createdDate: _editedPost.createdDate,
                      userId: '1',
                      pk: _editedPost.pk,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['content'],
                  decoration: InputDecoration(labelText: '내용'),
                  maxLines: 15,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  focusNode: _contentsFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '내용을 입력해주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedPost = Post(
                      title: _editedPost.title,
                      content: value,
                      createdDate: _editedPost.createdDate,
                      pk: _editedPost.pk,
                      userId: _editedPost.userId,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}