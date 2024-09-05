// lib/providers/post_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/strings/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;
  String _errorMessage = '';
  Post _postDetail = Post();

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Post? get postDetail => _postDetail;

  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          '${StringConstants.endPoint}${StringConstants.postListApi}'));

      if (response.statusCode == 200) {
        final List<dynamic> postsJson = json.decode(response.body);
        _posts = postsJson.map((json) => Post.fromJson(json)).toList();
        await _savePostsToLocal(); // Save to local storage
      } else {
        throw Exception(StringConstants.failedPostMsg);
      }
    } catch (error) {
      _errorMessage = StringConstants.internetErrorMsg;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostById(int postId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final url =
          '${StringConstants.endPoint}${StringConstants.postListApi}/$postId';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final postJson = json.decode(response.body);
        _postDetail = Post.fromJson(postJson);
      } else {
        throw Exception(StringConstants.failedPostMsg);
      }
    } catch (error) {
      _errorMessage = StringConstants.internetErrorMsg;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _savePostsToLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final postsJson =
          json.encode(_posts.map((post) => post.toJson()).toList());
      await prefs.setString(StringConstants.keyPost, postsJson);
    } catch (error) {
      _errorMessage = StringConstants.internetErrorMsg;
      notifyListeners();
    }
  }

  Future<void> loadPostsFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final postsJson = prefs.getString(StringConstants.keyPost);
      if (postsJson != null) {
        final List<dynamic> decodedJson = json.decode(postsJson);
        _posts = decodedJson.map((json) => Post.fromJson(json)).toList();
      }
    } catch (error) {
      _errorMessage = StringConstants.internetErrorMsg;
      notifyListeners();
    }
  }

  void clearSelectedPost() {
    _postDetail = Post();
    notifyListeners();
  }

  void markAsRead(int postId) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      _posts[postIndex].isRead = true;
      notifyListeners();
    }
  }
}
