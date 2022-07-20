import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/posts.dart';
import '../main/editPostPage.dart';
import '../widgets/post_item.dart';

class BoardPage extends StatelessWidget {
  static const routeName = './BoardPage';
  const BoardPage({Key? key}) : super(key: key);

  Future<void> _refreshPosts(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false).fetchAndSetPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditPostPage.routeName,
                  arguments: {'pk': null});
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshPosts(context),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: () => _refreshPosts(context),
          child: Consumer<Posts>(
            builder: (ctx, postsData, _) => Padding(
              padding: EdgeInsets.all(8),
              child: postsData.items.length > 0
                  ? ListView.builder(
                itemCount: postsData.items.length,
                itemBuilder: (_, i) => Column(
                  children: [
                    PostItem(
                      postsData.items[i].pk,
                    ),
                    Divider(),
                  ],
                ),
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.insert_drive_file_outlined,
                      size: 48,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'No Posts Yet',
                      textScaleFactor: 1.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  }