// lib/screens/post_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/strings/string_constants.dart';
import 'package:flutter_demo/utils/textStyle/common_text_style.dart';
import 'package:flutter_demo/utils/widgets/common_appbar.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';

class PostDetailScreen extends StatefulWidget {
  final int postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<PostProvider>(context, listen: false)
          .fetchPostById(widget.postId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(58),
            child: CommonAppBar(appTitle: StringConstants.postDetailTitle)),
        body: Consumer<PostProvider>(builder: (context, postProvider, child) {
          final post = postProvider.postDetail;
          return postProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : postProvider.errorMessage.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(postProvider.errorMessage)),
                    )
                  : postProvider.postDetail == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Center(child: Text(StringConstants.noPostData)),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(post?.title ?? '',
                                    style: CommonTextStyles.postDetailTitle),
                                const SizedBox(height: 16),
                                Text(post?.body ?? '',
                                    style: CommonTextStyles.postDetailSubText),
                              ]));
        }));
  }
}
