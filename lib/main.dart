import 'package:flutter/material.dart';
import 'package:flutter_demo/providers/post_provider.dart';
import 'package:flutter_demo/providers/time_povider.dart';
import 'package:flutter_demo/screens/post_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PostProvider()..fetchPosts()),
        ChangeNotifierProvider(create: (context) => TimerProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostListScreen(),
      ),
    );
  }
}
