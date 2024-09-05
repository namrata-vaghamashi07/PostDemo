// lib/widgets/post_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_demo/providers/time_provider.dart';
import 'package:flutter_demo/utils/colors/custom_color.dart';
import 'package:flutter_demo/utils/strings/string_constants.dart';
import 'package:flutter_demo/utils/textStyle/common_text_style.dart';
import 'package:provider/provider.dart';
import '../../models/post.dart';
import '../../providers/post_provider.dart';
import '../../screens/post_detail_screen.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final randomDuration = (10 + (post.id % 3) * 5);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.lightGreyColor), // Border color
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        tileColor:
            post.isRead ? CustomColor.whiteColor : CustomColor.lightYellowColor,
        title: Text(post.title ?? '', style: CommonTextStyles.postListTitle),
        trailing: IconButton(
          icon: const Icon(Icons.timer),
          onPressed: () {
            if (timerProvider.timers.containsKey(post.id)) {
              timerProvider.pauseTimer(post.id);
            } else {
              timerProvider.startTimer(post.id, randomDuration);
            }
          },
        ),
        subtitle: Consumer<TimerProvider>(
          builder: (context, timerProvider, child) {
            final timeLeft = timerProvider.timers[post.id]?.timeLeft ?? 0;
            return Text(
                '${Preference.timeLeft}  $timeLeft ${Preference.second}',
                style: CommonTextStyles.postListSubText);
          },
        ),
        onTap: () {
          Provider.of<PostProvider>(context, listen: false).markAsRead(post.id);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(postId: post.id),
            ),
          );
        },
      ),
    );
  }
}
