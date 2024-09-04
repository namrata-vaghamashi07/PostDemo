class Post {
  final int id;
  final String? title;
  final String? body;
  bool isRead;

  Post({
    this.id = 0,
    this.title,
    this.body,
    this.isRead = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      isRead: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead,
    };
  }
}
