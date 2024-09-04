import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/strings/string_constanst.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../utils/widgets/common_appbar.dart';
import '../utils/widgets/post_item.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: CommonAppBar(appTitle: StringConstants.postTitle)),
      body: Consumer<PostProvider>(
          builder: (ctx, postProvider, _) => postProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : postProvider.errorMessage.isNotEmpty
                  ? Center(child: Text(postProvider.errorMessage))
                  : postProvider.posts.isEmpty
                      ? Center(child: Text(StringConstants.noPostData))
                      : ListView.builder(
                          itemCount: postProvider.posts.length,
                          itemBuilder: (ctx, index) =>
                              PostItem(post: postProvider.posts[index]))),
    );
  }
}
