// lib/widgets/post_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/strings/string_constanst.dart';
import 'package:provider/provider.dart';
import '../../models/post.dart';
import '../../providers/post_provider.dart';
import '../../providers/time_povider.dart';
import '../../screens/post_detail_screen.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return ListTile(
      tileColor: post.isRead ? Colors.white : Colors.yellow[100],
      title: Text(post.title ?? ''),
      trailing: IconButton(
        icon: const Icon(Icons.timer),
        onPressed: () {
          if (timerProvider.isRunning) {
            timerProvider.pauseTimer();
          } else {
            timerProvider.startTimer(10 + (post.id % 3) * 5);
          }
        },
      ),
      subtitle: Text(
          '${StringConstants.timeLeft} ${timerProvider.timeLeft} ${StringConstants.secound}'),
      onTap: () {
        Provider.of<PostProvider>(context, listen: false).markAsRead(post.id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(postId: post.id),
          ),
        );
      },
    );
  }
}
