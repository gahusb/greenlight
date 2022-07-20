import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../main/postDetailPage.dart';
import '../providers/posts.dart';
import '../providers/comments.dart';


class PostItem extends StatelessWidget {
  final String? id;
  PostItem(
      this.id,
      );

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context, listen: false).items;
    final postIndex = posts.indexWhere((post) => post.pk == id);
    final post = posts[postIndex];

    return ListTile(
      title: Text(
        post.title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        post.content!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: (DateTime.now().day - post.createdDate!.day >= 1)
          ? Text(DateFormat('MM/dd', 'ko').format(post.createdDate!))
          : Text(DateFormat('HH:mm', 'ko').format(post.createdDate!)),
      onTap: () async {
        // await Provider.of<Comments>(context, listen: false)
        //     .fetchAndSetComments(id!);
        Navigator.of(context)
            .pushNamed(PostDetailPage.routeName, arguments: post);
      },
    );
  }
}