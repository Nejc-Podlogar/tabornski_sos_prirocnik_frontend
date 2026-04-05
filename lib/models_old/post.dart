

class Post {
  final String title;
  final String content;
  final String? link;

  Post({required this.title, required this.content, this.link});

  Post copyWith({String? title, String? content, String? link}) {
    return Post(
      title: title ?? this.title,
      content: content ?? this.content,
      link: link ?? this.link
    );
  }

}