// lib/screens/post_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/strings/string_constants.dart';
import 'package:flutter_demo/utils/widgets/common_appbar.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(58),
            child: CommonAppBar(appTitle: Preference.postDetailTitle)),
        body: Consumer<PostProvider>(builder: (context, postProvider, child) {
          final post = postProvider.postDetail!;
          return postProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : postProvider.errorMessage.isNotEmpty
                  ? Center(child: Text(postProvider.errorMessage))
                  : postProvider.postDetail == null
                      ? Center(child: Text(Preference.noPostData))
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(post.title ?? '',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 16),
                                Text(post.body ?? ''),
                              ]));
        }));
  }
}
